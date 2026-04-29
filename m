Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E1A22F74A;
	Wed, 29 Apr 2026 18:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486893; cv=none; b=YfTZbAkVHnCyM5nVHczxw+aZfvIexbk9dU85hT7uLHmfEkjaou4SxLSf2df4HeVpdwMk18qMcyJmARDN8heqXKX0ygisjep6dF2wPQ0gqOisDYrsMBGCLD1Rh9dWWaYXaU3uTjEryVVsAp9lJfsqQOFPEp8QmCu+uUCV/NIyWwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486893; c=relaxed/simple;
	bh=VBw2xcpHPF/aEUglZNdQkwZaJz8eemEyry/WqAC7e6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K7Z7Pc1SMfzQ8wOhf6zyqMVJYVDUxO8oY76jL5MNLrPx+1pXjrDn8t+4DzZrcmaCqkSgLyCr1Rks/APAFxjhpCmltBXuSln5vLV0doLFKzofsIc9n/C5FlK2TI3VlwanWOoVd0/VEPgYGwfMTNk9jfwrz7S4AzSfZzCeGGBXU6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ka5+vLz7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ka5+vLz7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AFAC19425;
	Wed, 29 Apr 2026 18:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777486893;
	bh=VBw2xcpHPF/aEUglZNdQkwZaJz8eemEyry/WqAC7e6k=;
	h=From:To:Cc:Subject:Date:From;
	b=Ka5+vLz7eccy62nVXctjM3SANZcfu+QNRt4L2KOrxobc9ldOudn4GdCSUBt3wPCAu
	 pc2mhHTrTluIPJPjR4eLxPVoLV7dUahjI9VfHt0SSC1jhmognKuaDQ9Y/raRZmHbGh
	 XylrSg0YRhtrrnq1+SKbVHopCzDDfC67oD+1jA1MTWeVk2q35lIhi3ESsM4Vkcy3RX
	 N3y3Drc3nKfET12+RINdOflnFdhOhTGs5cOvWjcoqPnVqn1DBldOpDcpsFIIreTsjw
	 78xaQkmadjitbvH3tHOMAXY5Iz5vMFO0bT00G5KT/QXJz+dVWJB1UzHkvYyJJfCxQW
	 XmdwykdC7jR+Q==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v4 sched_ext/for-7.2] sched_ext: Topological CPU IDs and cid-form struct_ops
Date: Wed, 29 Apr 2026 08:21:14 -1000
Message-ID: <20260429182131.1780125-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

v4:
- cmask: bump CMASK_CAS_TRIES to (1U << 23) so abort fires only after
  seconds of real spinning, not on plausible contention. The kfunc
  slow-path Changwoo suggested would let BPF loops keep banging a
  contended cacheline indefinitely - on multi-socket SPRs that path
  can stall the machine into hard lockups, so failing hard is the
  right behavior. A follow-up patch will add a kfunc to bail the BPF
  CAS loops immediately when sch->aborting is set. Switch
  __builtin_ctzll() to the ctzll() wrapper for clang compat.
- cid-qmap-port: cid-shard handling was wired against a future kfunc
  signature that didn't make it into v3, leaving the snapshot broken.
  Drop the shard test plumbing for v4, match the 2-arg
  scx_bpf_cid_override(), bound nr_cpu_ids for the verifier, and
  rename mode 3 from bad-mono to bad-range. (Changwoo, Andrea)
- Rebased over the exit_cpu plumbing in for-7.2:
    scx-error-header: scx_exit() and scx_verror() are macros now;
    move both plus the underlying __scx_exit() / scx_vexit()
    declarations to ext_internal.h.
    cid-struct-ops: dump_cpu callsite shifted into scx_dump_cpu()
    helper; the scx_cpu_arg() wrap moved with it.

v3: https://lore.kernel.org/r/20260428203545.181052-1-tj@kernel.org
v2: https://lore.kernel.org/r/20260424172721.3458520-1-tj@kernel.org
v1: https://lore.kernel.org/r/20260421071945.3110084-1-tj@kernel.org

This patchset introduces topological CPU IDs (cids) - dense,
topology-ordered cpu identifiers - and an alternative cid-form struct_ops
type that lets BPF schedulers operate in cid space directly.

Key pieces:

- cid space: scx_cid_init() walks nodes * LLCs * cores * threads and packs
  a dense cid mapping. The mapping can be overridden via
  scx_bpf_cid_override(). See "Topological CPU IDs" in ext_cid.h for the
  model.

- cmask: a base-windowed bitmap over cid space. Kernel and BPF helpers with
  identical semantics. Used by scx_qmap for per-task affinity and idle-cid
  tracking; meant to be the substrate for sub-sched cid allocation.

- bpf_sched_ext_ops_cid: a parallel struct_ops type whose callbacks take
  cids/cmasks instead of cpus/cpumasks. Kernel translates at the boundary
  via scx_cpu_arg() / scx_cpu_ret(); the two struct types share offsets up
  through @priv (verified by BUILD_BUG_ON) so the union view in scx_sched
  works without function-pointer casts. Sub-sched support is tied to
  cid-form: validate_ops() rejects cpu-form sub-scheds and cpu-form roots
  that expose sub_attach / sub_detach.

- cid-form kfuncs: scx_bpf_kick_cid, scx_bpf_cidperf_{cap,cur,set},
  scx_bpf_cid_curr, scx_bpf_task_cid, scx_bpf_this_cid,
  scx_bpf_nr_{cids,online_cids}, scx_bpf_cid_to_cpu, scx_bpf_cpu_to_cid.
  A cid-form program may not call cpu-only kfuncs (enforced at verifier
  load via scx_kfunc_context_filter); the reverse is intentionally
  permissive to ease migration.

- scx_qmap port: scx_qmap is converted to cid-form. It uses the cmask-based
  idle picker, per-task cid-space cpus_allowed, and cid-form kfuncs
  throughout. Sub-sched dispatching via scx_bpf_sub_dispatch() continues to
  work.

v4 re-tested on the 16-cpu QEMU VM with the v3 cut (only the 17 cid
patches applied): basic load + stress, cid-override modes
(shuffle/bad-dup/bad-range), and three enable/disable cycles all clean.
No BUG/WARNING/panic in the dump.

Based on sched_ext/for-7.2 (ee8391ba1164).

  0001-sched_ext-Add-ext_types.h-for-early-subsystem-wide-d.patch
  0002-sched_ext-Rename-ops_cpu_valid-to-scx_cpu_valid-and-.patch
  0003-sched_ext-Move-scx_exit-scx_error-and-friends-to-ext.patch
  0004-sched_ext-Shift-scx_kick_cpu-validity-check-to-scx_b.patch
  0005-sched_ext-Relocate-cpu_acquire-cpu_release-to-end-of.patch
  0006-sched_ext-Make-scx_enable-take-scx_enable_cmd.patch
  0007-sched_ext-Add-topological-CPU-IDs-cids.patch
  0008-sched_ext-Add-scx_bpf_cid_override-kfunc.patch
  0009-tools-sched_ext-Add-struct_size-helpers-to-common.bp.patch
  0010-sched_ext-Add-cmask-a-base-windowed-bitmap-over-cid-.patch
  0011-sched_ext-Add-cid-form-kfunc-wrappers-alongside-cpu-.patch
  0012-sched_ext-Add-bpf_sched_ext_ops_cid-struct_ops-type.patch
  0013-sched_ext-Forbid-cpu-form-kfuncs-from-cid-form-sched.patch
  0014-tools-sched_ext-scx_qmap-Restart-on-hotplug-instead-.patch
  0015-tools-sched_ext-scx_qmap-Add-cmask-based-idle-tracki.patch
  0016-tools-sched_ext-scx_qmap-Port-to-cid-form-struct_ops.patch
  0017-sched_ext-Require-cid-form-struct_ops-for-sub-sched-.patch

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-cid-v4

 kernel/sched/build_policy.c              |   3 +
 kernel/sched/ext.c                       | 660 ++++++++++++++++++++++++++----
 kernel/sched/ext_cid.c                   | 409 +++++++++++++++++++
 kernel/sched/ext_cid.h                   | 164 ++++++++
 kernel/sched/ext_idle.c                  |   8 +-
 kernel/sched/ext_internal.h              | 209 +++++++---
 kernel/sched/ext_types.h                 | 104 +++++
 tools/sched_ext/include/scx/cid.bpf.h    | 666 +++++++++++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  23 ++
 tools/sched_ext/include/scx/compat.bpf.h |  24 ++
 tools/sched_ext/scx_qmap.bpf.c           | 350 +++++++++-------
 tools/sched_ext/scx_qmap.c               |  57 ++-
 tools/sched_ext/scx_qmap.h               |   2 +-
 13 files changed, 2387 insertions(+), 292 deletions(-)

Thanks.

--
tejun
