Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B222E7623;
	Tue, 28 Apr 2026 20:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777408547; cv=none; b=kidIVGgrd+UEiqApTnYdgadvGtp8vy2Vzx3/Q+SNK0MPupj6wNarIr7h+OfsJ6HsRknVItP2ZS3gt87G6uUDeWlxIIE466AjcioZDUWEnRlo9J3Sw1zubIvYEdUI5STIhhJqt4ikZBBFZiGI+9QFVbfGtmWqA386kgXHVn67Xww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777408547; c=relaxed/simple;
	bh=SF+gMmHC0/V+w4B5gtgrq96vcjIFcd74d0xu9BHaX/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IhV1wZsJ+r8ZP7GyVKpRSsCoUDJpw5gJ7pxab8QnXfaJMLT1vdKyH1Ie/IrnYjf22hw1zh72y1FDT5SFQnhiSdDju5DIjUmP5Z8/775NDIoHEl9Q8+hqrJewT62BkP8MHBvJLWycil2zJToPUOYgLEr7NfL/Rc0Zv/7+TIYSttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hssoJTIS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hssoJTIS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3BDC2BCB3;
	Tue, 28 Apr 2026 20:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777408547;
	bh=SF+gMmHC0/V+w4B5gtgrq96vcjIFcd74d0xu9BHaX/U=;
	h=From:To:Cc:Subject:Date:From;
	b=hssoJTISbcliOI7QJYhcuGs84QL7W8SDOAYGru7UKYPOqAVCOpLLBLLvZ34o0BQQ7
	 NxITB/bKwA8qGMKe0sAF40kwiMvN2nArHxInIi6+RghPhT7P5++i2lF/FcnIAqKZJ1
	 EAW0V2Hkiv6JhlcWqfV0f+guIpIW2R8xh7AMIus09Y+2XRAw9GDv8cbozxnTxdm6Os
	 2gcKNna07Ej19ZdIYqZ0jCGHUmrxbLq5UREFVoCER4CvB5BN8eIYb7aQlZxOX99xAg
	 6blJoAZ7RdKf6yY2dx/TOwU6XbQxJRI0YHZ+hb0V44rXBi4VTsYR5P+X8T0+XRB+y+
	 oieODSROkSK1Q==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v3 sched_ext/for-7.2] sched_ext: Topological CPU IDs and cid-form struct_ops
Date: Tue, 28 Apr 2026 10:35:28 -1000
Message-ID: <20260428203545.181052-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

v3 (all from the Sashiko AI review at
https://sashiko.dev/#/patchset/20260424172721.3458520-1-tj%40kernel.org):

- cid: drop leaked cpus_read_lock() on scx_cid_init() failure;
  BUILD_BUG_ON tightened to NR_CPUS<=8192 to match the BPF cmask
  helpers' CMASK_MAX_WORDS coverage.
- bpf-struct-size: use offsetof() in struct_size() to match the
  kernel <linux/overflow.h> macro semantics (no inflation from
  trailing struct padding).
- cmask: cmask_copy_from_kernel() validates src->base==0 via
  probe-read; nr_bits check is bit-level rather than rounded-up
  word-count.
- cid-qmap-idle: qmap_init() refuses to load when scx_bpf_nr_cids()
  exceeds SCX_QMAP_MAX_CPUS; the task_ctx flex array would otherwise
  overflow into the next slab entry.

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

v3 re-tested on the 16-cpu QEMU: cid-form scx_qmap under stress-ng plus
reload cycles, hotplug auto-restart, and sub-sched (root scx_qmap +
cgroup-scoped scx_qmap child). Clean.

Based on sched_ext/for-7.2 (4939721aad2e).

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

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-cid-v3

 kernel/sched/build_policy.c              |   3 +
 kernel/sched/ext.c                       | 651 ++++++++++++++++++++++++++----
 kernel/sched/ext_cid.c                   | 409 +++++++++++++++++++
 kernel/sched/ext_cid.h                   | 164 ++++++++
 kernel/sched/ext_idle.c                  |   8 +-
 kernel/sched/ext_internal.h              | 205 +++++++---
 kernel/sched/ext_types.h                 | 104 +++++
 tools/sched_ext/include/scx/cid.bpf.h    | 667 +++++++++++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  23 ++
 tools/sched_ext/include/scx/compat.bpf.h |  24 ++
 tools/sched_ext/scx_qmap.bpf.c           | 346 +++++++++-------
 tools/sched_ext/scx_qmap.c               |  70 +++-
 tools/sched_ext/scx_qmap.h               |   2 +-
 13 files changed, 2391 insertions(+), 285 deletions(-)

Thanks.

--
tejun
