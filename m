Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DFA3254A8;
	Sun, 17 May 2026 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041424; cv=none; b=sRkQYkw5pame8fN3wl2jl1TdgU2ciisf65UnJI9+2nb0/ndQVWC/SV13wFP9zP7XQuWruFyG5LIn+v3QvYf18696+ZXMvTNYfOgM+mY77CGF6X0OF2z6+aZhLgSG/rR7Q326o2sO9gG/zBZ4YR3bzU25qACepcCXy3JyhLB5GJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041424; c=relaxed/simple;
	bh=yzcx3yoiV3gKjP8QE/TRZq9fb1JpgUnCTeRgfxXjrjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o6gSL+K322++P4uyML79zEAxcbzssBnOTVauFFtifOUYyo7Zxcgolsz8+mzMXVgjxl6STYnQ9hqeAjedtsV/OZMMR7FoYIhk8YLa3W6457Qb7N4dFJOCu+xFaJtoxxvM00UmpRaRouQn0jTq06a0SnR2JnpztnQnT25w702KKYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+sw288Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+sw288Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C61FC2BCB0;
	Sun, 17 May 2026 18:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779041423;
	bh=yzcx3yoiV3gKjP8QE/TRZq9fb1JpgUnCTeRgfxXjrjE=;
	h=From:To:Cc:Subject:Date:From;
	b=C+sw288QNu8rHA8gBB34OrEVa6wuO13dSWB/tPU6FwUzedD7uXBVGX90CwyIdlmL1
	 5chcUFT0jBhSc5pK60/MXm+1/FB5ltpxGZO2Kxr5yy4NIh2gXJewQyDNuVItCP89hr
	 X9Dg2v47brGOJkluRQqa22nVDdKqwofiMubuubHV8iITR436ecrjl1qM8Vl0Q7l0gw
	 in3RRvJakKfnMvDJ3/5xwNoQKN4YpRuxxQZ7qduK7mEWcj2nrL100JM+kiBh8PhbCY
	 J1hXUL9RWMdU2MThCireDakWjHKirAAGt747Xlhpt2MvgSTzClrJZwctX4JCQMXOas
	 9KJssoFzJAeHA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v2 INTERNAL] bpf/arena: Direct kernel-side access
Date: Sun, 17 May 2026 08:10:19 -1000
Message-ID: <20260517181022.1184056-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Internal preview of v2 before public posting. Recipients are only the
three of you for review.

Motivation
----------

sched_ext's ops_cid.set_cmask() hands the BPF scheduler a struct
scx_cmask *. The kernel translates a kernel cpumask to a cmask, but it
had no way to write into the arena, so the cmask lived in kernel memory
and was passed as a trusted pointer. BPF cmask helpers all operate on
arena cmasks though, so the BPF side had to word-by-word probe-read the
kernel cmask into an arena cmask via cmask_copy_from_kernel() before
any helper could touch it. It works, but is clumsy.

The shape isn't unique to set_cmask. Sub-scheduler support is on the
way and more sched_ext callbacks will want to pass structured data to
BPF. Anywhere a kfunc or struct_ops callback wants to hand a struct to
a BPF program, arena residence is the natural answer.

Approach
--------

Each arena gets a per-arena scratch page. Arenas stay sparsely mapped
as today - PTEs are populated only for allocated pages. A new arch
fault hook (bpf_arena_handle_page_fault) is wired into x86
page_fault_oops() and arm64 __do_kernel_fault(), after KFENCE. When a
kernel-side access faults inside an arena's kern_vm range, the helper
walks the stack to find the BPF program responsible, range-checks the
fault address against prog->aux->arena, and atomically installs the
scratch page into the empty PTE via a new ptep_try_install() wrapper.
The kernel instruction then retries and reads/writes the scratch page.
Real allocations naturally overwrite scratch PTEs; free paths and map
destruction treat scratch as non-owned.

The mechanism is default behavior - no UAPI flag.

What this preserves
-------------------

All the debugging properties of today's sparse-PTE design are
preserved:

* BPF programs still fault on unmapped arena accesses. The fault
  semantics (instruction retry with rdst = 0) and the violation
  report through bpf_streams are unchanged for prog-side accesses.
* The first kernel-side touch of an unmapped address is reported via
  bpf_streams the same way as a prog-side fault, with the stack walk
  attributing it to the originating prog.
* User-side fault semantics are unchanged. arena_vm_fault() treats a
  scratch PTE as absent and lazy-allocates a real page (or returns
  SIGSEGV under BPF_F_SEGV_ON_FAULT) the same as before.
* Repeat kernel-side faults on the same address after a free still
  re-install scratch, so the slot's "bad access" is reported on every
  fresh occurrence; only repeat faults without an intervening free
  are absorbed.

What changes for the kernel-side caller is just that an unmapped
deref no longer oopses - it retries through the scratch page and
emits a violation report. The same shape today's BPF instruction
faults have.

Patches 1-2 (atomic PTE install + arena scratch-page recovery)
--------------------------------------------------------------

  mm: Add ptep_try_install() for lockless empty-slot installs
  bpf: Recover arena kernel faults with scratch page

Patches 3-5 (helpers used by struct_ops registration)
-----------------------------------------------------

  bpf: Add sleepable variant of bpf_arena_alloc_pages for kernel callers
  bpf: Add bpf_struct_ops_for_each_prog()
  bpf/arena: Add bpf_arena_map_kern_vm_start() and bpf_prog_arena()

Patches 6-8 (sched_ext: arena auto-discovery, allocator, set_cmask)
-------------------------------------------------------------------

  sched_ext: Require an arena for cid-form schedulers
  sched_ext: Sub-allocator over kernel-claimed BPF arena pages
  sched_ext: Convert ops.set_cmask() to arena-resident cmask

Patch 6 reads each member prog's prog->aux->arena via bpf_prog_arena()
and requires the cid-form struct_ops to reference exactly one arena.
Patch 7 builds a gen_pool sub-allocator inside that arena. Patch 8
converts set_cmask() to write into arena memory; BPF dereferences via
__arena like any other arena struct, no probe-reads.

v1 -> v2
--------

* Dropped the BPF_F_ARENA_MAP_ALWAYS uapi flag and pre-populated
  garbage page. Replaced by lazy scratch-page install on first
  kernel-side fault.
* Dropped bpf-arena-pte-cb-prep: callbacks read scratch_page from a
  field in their data struct, not via arena indirection.
* Dropped bpf-prog-for-each-used-map: verifier already enforces one
  arena per prog (prog->aux->arena), so iteration over used_maps is
  unnecessary. bpf_prog_arena() exposes the prog's arena directly.
* New ptep_try_install() in <linux/pgtable.h>: the atomic install
  primitive used by the arena fault helper. Generic stub returns
  false; x86 and arm64 override with try_cmpxchg.

Base
----

sched_ext/for-7.2 with for-7.1-fixes merged in (de79a6cb3c3e).

v1 RFC for reference:
https://lore.kernel.org/all/20260427105109.2554518-1-tj@kernel.org/

 arch/arm64/include/asm/pgtable.h      |   8 ++
 arch/arm64/mm/fault.c                 |   4 +
 arch/x86/include/asm/pgtable.h        |   8 ++
 arch/x86/mm/fault.c                   |   5 ++
 include/linux/bpf.h                   |  14 ++++
 include/linux/pgtable.h               |  16 ++++
 kernel/bpf/arena.c                    | 141 +++++++++++++++++++++++++++++++---
 kernel/bpf/bpf_struct_ops.c           |  36 +++++++++
 kernel/bpf/core.c                     |   5 ++
 kernel/sched/build_policy.c           |   4 +
 kernel/sched/ext.c                    | 132 +++++++++++++++++++++++++++++--
 kernel/sched/ext_arena.c              | 128 ++++++++++++++++++++++++++++++
 kernel/sched/ext_arena.h              |  18 +++++
 kernel/sched/ext_cid.c                |  16 +---
 kernel/sched/ext_internal.h           |  24 +++++-
 kernel/sched/ext_types.h              |  10 +++
 tools/sched_ext/include/scx/cid.bpf.h |  52 -------------
 tools/sched_ext/scx_qmap.bpf.c        |   6 +-
 18 files changed, 540 insertions(+), 87 deletions(-)

Thanks.
--
tejun
