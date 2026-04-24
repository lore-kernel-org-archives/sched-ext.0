Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE775801;
	Fri, 24 Apr 2026 01:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776994342; cv=none; b=bRfsFSvNPZ6k5kLpLEySZc/1ywxq1Q6rMJGisqiaNVPB+tv88H9xoyshayxGUtJiEp0JIR/pGv0kgATEVcbJdTLM5VTgqxqGeCcMX3QsIaO+uWrO3Sh1GQ8tJa/7s4ukHUZ8GZzyeY8mKHSnhIEIcz5egFj8bvjiD+ww/U0S2Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776994342; c=relaxed/simple;
	bh=4qk8mgwdMlpiyWFIxlVE/CktR07iSQhTW0+dQ+sngyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YWS6CFoLDdXQGBcb0WWkwWOX2PnTofIxDKJ5df8z6b4om/3NcZzAX2QaEhEjdwQNn/jzrR/fa94V+ajajsioWUSP/J0A+W9nhPv0jY8fkJeOz5xDOVvKvuh7sCBv+dbppU5/OMVsvfTAkehNoOR8nonbAnSyEUGsp4WNF1iR0+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tX6ogE5c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tX6ogE5c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3DBC2BCAF;
	Fri, 24 Apr 2026 01:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776994341;
	bh=4qk8mgwdMlpiyWFIxlVE/CktR07iSQhTW0+dQ+sngyk=;
	h=From:To:Cc:Subject:Date:From;
	b=tX6ogE5csdiNH+uVUbe29lnhVGx0o5xDwZezRoNlkc/2YZeFAG2ssnW0WGCUaI4eR
	 eoF5Gdees+bcthbtTNNeTw2OA2ySV1hzq+6iig+GmLOcxwVroKOoHS5WEXpr0N9kCy
	 oEzCmfCbBrgp/VZyTYL0UKA/HElbVWDojConi/SN3GMWr+kYnKpE+NEtkrVjNurV64
	 kvRW7JhbLVSPjVmZssgLxzCzrtaXbAG3DHpd/W1Pmpy6zk2CM6QiOUzid1k771VTUD
	 CocrnIyP6SHFiTBkEAMdZZ8c0OYUrR5MqssHjHmVBkpBx+6bHdaf+FDiNqEMvNm3+1
	 HGCm1TOtbsfOw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Zhao Mengmeng <zhaomzhao@126.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v2 sched_ext/for-7.2] sched_ext: Topological CPU IDs and cid-form struct_ops
Date: Thu, 23 Apr 2026 15:32:03 -1000
Message-ID: <20260424013220.2923402-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

v2 of https://lore.kernel.org/r/20260421071945.3110084-1-tj@kernel.org

v2:
- Add ext-types.h first patch for early subsystem-wide type defs.
- cid: publish the cid tables with WRITE_ONCE / read with READ_ONCE;
  document the visibility contract.
- cid-kfuncs: NULL-guard scx_bpf_this_cid / scx_bpf_task_cid for
  TRACING/SYSCALL callers before any SCX sched has enabled.
- cid-struct-ops: use struct_size() for the set_cmask_scratch percpu
  alloc; cluster __scx_is_cid_type disable with __scx_enabled disable
  in scx_root_disable().
- cid-kfunc-filter: sync per-entry kfunc flags with each kfunc's
  primary BTF_ID_FLAGS() declaration (Zhao). pahole intersects flags
  across occurrences; omitting them drops the flags globally - the
  visible symptom was KF_IMPLICIT_ARGS getting cleared on
  scx_bpf_kick_cpu, leaking bpf_prog_aux into vmlinux.h.
- cmask: narrow to the helpers this series actually uses;
  cmask_copy_from_kernel contract and runtime guard.

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

v2 re-tested on the 16-cpu QEMU: cid-form scx_qmap, cpu-form scx_simple,
cid<->cpu cycling, scx_qmap under stress-ng, hotplug auto-restart, and
sub-sched (root scx_qmap + cgroup-scoped scx_qmap child). Clean.

Based on sched_ext/for-7.2 (c2929bc21dce).

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

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-cid-v2

 kernel/sched/build_policy.c              |   2 +
 kernel/sched/ext.c                       | 650 +++++++++++++++++++++++++----
 kernel/sched/ext_cid.c                   | 417 ++++++++++++++++++++
 kernel/sched/ext_cid.h                   | 164 ++++++++
 kernel/sched/ext_idle.c                  |   8 +-
 kernel/sched/ext_internal.h              | 203 +++++++---
 kernel/sched/ext_types.h                 | 104 +++++
 tools/sched_ext/include/scx/cid.bpf.h    | 597 ++++++++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  23 ++
 tools/sched_ext/include/scx/compat.bpf.h |  24 ++
 tools/sched_ext/scx_qmap.bpf.c           | 306 ++++++++-------
 tools/sched_ext/scx_qmap.c               |  25 +-
 tools/sched_ext/scx_qmap.h               |   2 +-
 13 files changed, 2240 insertions(+), 285 deletions(-)

--
tejun
