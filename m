Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BE735C18C;
	Tue, 21 Apr 2026 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776755986; cv=none; b=t25aI5IeyxTbvQKSdjZS0HTIDZ4kCl9mEcQqNaHUqt3/sd3Z4FLzMhwhjliPECQotRH6xYbHX+9nIt9Z0/sr5f3fw2GZhUPeP/FzfH0q5XQ1djc9k9fUDkmOx9HZfCCoO4TIdLH+rfPASrhjNBYRe0V0DrX2kSTpi52CeKvb/pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776755986; c=relaxed/simple;
	bh=hryybqpBE3zbpxQvAS3GplyfvXoVlL2eFAbq0QLsUNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=okorHXe3JX7IEZLO/77wiK6235icaNSjzUKJMx5n8yxvMdiz6l5Yh5w6cTuQ8w9F4a4i9CqdGBEJo+lt6q/fqWlrFArSkMnFCor9vh2+60SFQ7nKWxEBK6envlTBb8H/FQvSpXxaAxQCH7kWKqH1HGyYrd+JhNXr2waTr71SIwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BujBubw5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BujBubw5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDBFC2BCB0;
	Tue, 21 Apr 2026 07:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776755986;
	bh=hryybqpBE3zbpxQvAS3GplyfvXoVlL2eFAbq0QLsUNA=;
	h=From:To:Cc:Subject:Date:From;
	b=BujBubw5hL0tiIZtOeH1yDtyR8lHeRAB+VsRcH1PK0wTJrwyTKAeVquWxpYA1c2f/
	 VGQsJtR7vHhsb/Io7MdAwagpGBXGgKzxELrfuIbQg/jNM/cyiL7QHqap7Rk5VepB4M
	 6u+OLp5Kp4Khv0+fIiMtMibQzsTIpPvvr/i35qh7XG0plTJq7ngh0QzfZd6efoer1K
	 7h4L/in3VHWDsp8UyNWvRlFYJYiytNBK4FRfdleFmLrwxaYsiOZyv27IYSE0R/fm6Q
	 WjKmvowTY86nVzcQmz+xxiOiFSqlQThmF8Dx6mPiG/oZK/0ut22wq9rKNhLCj01q8O
	 MXX94O4UInxsg==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.2] sched_ext: Topological CPU IDs and cid-form struct_ops
Date: Mon, 20 Apr 2026 21:19:29 -1000
Message-ID: <20260421071945.3110084-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

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

End-to-end testing on a 16-cpu QEMU (identity mapping) and an AMD Ryzen
9 3900X (non-identity cid mapping across CCXes) validated:
- cid <-> cpu table roundtrip
- SCX_DSQ_LOCAL_ON | cid routing (pinned workers land on the right cpu)
- scx_bpf_kick_cid translation (traced entry vs scx_kick_cpu exit)
- set_cmask fidelity (bits match cpu_to_cid(task->cpus_ptr))
- idle picker engagement under light load, backoff under saturation
- sub-sched qmap (root + 3 subs across cgroups)
- cpu-form regression (scx_simple, scx_flatcg still load and schedule)
- kfunc filter denial (cid-form calling scx_bpf_task_cpu rejected at load)

The patchset depends on a pre-existing bug fix that is being submitted
separately to for-7.1-fixes:

  "tools/sched_ext: scx_qmap: Silence task_ctx lookup miss"
  https://lore.kernel.org/r/59bc5171ee5aa02746c2f576d0f1e14f@kernel.org

The scx-cid-base branch listed below already carries that fix merged
through for-7.1-fixes; when for-7.1-fixes is merged back into for-7.2
the dependency resolves naturally.

Based on sched_ext/for-7.2 (12ff49d4e1d9) + for-7.1-fixes + the above fix
(scx-cid-base at 5755954f68ad).

 0001-sched_ext-Rename-ops_cpu_valid-to-scx_cpu_valid-and-.patch
 0002-sched_ext-Move-scx_exit-scx_error-and-friends-to-ext.patch
 0003-sched_ext-Shift-scx_kick_cpu-validity-check-to-scx_b.patch
 0004-sched_ext-Relocate-cpu_acquire-cpu_release-to-end-of.patch
 0005-sched_ext-Make-scx_enable-take-scx_enable_cmd.patch
 0006-sched_ext-Add-topological-CPU-IDs-cids.patch
 0007-sched_ext-Add-scx_bpf_cid_override-kfunc.patch
 0008-tools-sched_ext-Add-struct_size-helpers-to-common.bp.patch
 0009-sched_ext-Add-cmask-a-base-windowed-bitmap-over-cid-.patch
 0010-sched_ext-Add-cid-form-kfunc-wrappers-alongside-cpu-.patch
 0011-sched_ext-Add-bpf_sched_ext_ops_cid-struct_ops-type.patch
 0012-sched_ext-Forbid-cpu-form-kfuncs-from-cid-form-sched.patch
 0013-tools-sched_ext-scx_qmap-Restart-on-hotplug-instead-.patch
 0014-tools-sched_ext-scx_qmap-Add-cmask-based-idle-tracki.patch
 0015-tools-sched_ext-scx_qmap-Port-to-cid-form-struct_ops.patch
 0016-sched_ext-Require-cid-form-struct_ops-for-sub-sched-.patch

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-cid

 kernel/sched/build_policy.c              |   1 +
 kernel/sched/ext.c                       | 635 +++++++++++++++++++++++++----
 kernel/sched/ext_cid.c                   | 554 +++++++++++++++++++++++++++
 kernel/sched/ext_cid.h                   | 327 ++++++++++++++++
 kernel/sched/ext_idle.c                  |   8 +-
 kernel/sched/ext_internal.h              | 173 +++++++--
 tools/sched_ext/include/scx/cid.bpf.h    | 595 +++++++++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  23 ++
 tools/sched_ext/include/scx/compat.bpf.h |  24 ++
 tools/sched_ext/scx_qmap.bpf.c           | 304 ++++++-------
 tools/sched_ext/scx_qmap.c               |  25 +-
 tools/sched_ext/scx_qmap.h               |   2 +-
 12 files changed, 2419 insertions(+), 252 deletions(-)

--
tejun
