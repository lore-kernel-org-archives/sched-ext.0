Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836CB3F23C5;
	Wed, 29 Apr 2026 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466958; cv=none; b=s4DXNuBo3beBc1gCW2FjG4O5eDEFHIvW0z0wZZ+dFbkRykWPskBKAyIoFOVw5EWyDcKQqjR2+cgaIk0FPO/hv+MaTzCSi83hqS6RyoJatiwG/5zHykidOb0BUNgumk82zPt9b1FJ07KRXIYmerYOpWSd1JBGIHV98DBczLiyZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466958; c=relaxed/simple;
	bh=Wrf/2kC6tWx3K7/KkvAf7ANA76q19HdE7qCdN66tFU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJGHPgIxkyuPClRuGZsAetZB3WIpJCBHmZ8i6RvtR2d578zcOqz1pfSBeYvHSqqhV3OiRMaEOAx7Ra6Q0djW3d1kWWAHCJ3SSHFGb7smsWtbddgJ7JG5FhzLB/z0gmQnCgPGKVL+kSeOWxOe44yNaZUCpKd4g2iRNYlXVDQl3NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Z9br0Uk2; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Z9br0Uk2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kgfPcN2ICmid9UbD4tLqJBrCWBSEv+QXk+ww21bOifY=; b=Z9br0Uk2qLBswSWsgULX8mqpgi
	zyLe5a9/pGSMgz8fMcsP6tgif8LLHR5m2iFPKh+RgCgxmtPHpkISKcK9MDwoM6afG3chIJJX63zda
	/X8Oh/OvayVdUhOW1+ISn1WKOlkpUZG3Vk5aM/W8Z70BO2lw0cq0FsPXkXcihitOyHhhV1Y8Yu9y6
	3rxXszGu0T8+D4G1e9pwe4QtGDKEY43ZE6Sk4bpFT34RaO2AiQLIyuCzzJTT6yAjJqChD70z9D72h
	oJx1aib5GvqeRSgBQnKYjNE6Y4t01tq6p8vekkjNK8H3DAEY/Jsz7wMHdU0Gi3z3KsEhRPX18tfGN
	ySDtCbmg==;
Received: from [58.29.145.179] (helo=[192.168.8.203])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wI4Lm-003w8R-Iv; Wed, 29 Apr 2026 14:49:10 +0200
Message-ID: <6262aacd-cae7-455a-96ef-ea9a4b1949b7@igalia.com>
Date: Wed, 29 Apr 2026 21:49:05 +0900
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v3 sched_ext/for-7.2] sched_ext: Topological CPU IDs
 and cid-form struct_ops
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
References: <20260428203545.181052-1-tj@kernel.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20260428203545.181052-1-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you, Tejun, for the patchset.
I like it! I made some comments on patches 10 and 16.

Reviewed-by: Changwoo Min <changwoo@igalia.com>

On 4/29/26 5:35 AM, Tejun Heo wrote:
> Hello,
> 
> v3 (all from the Sashiko AI review at
> https://sashiko.dev/#/patchset/20260424172721.3458520-1-tj%40kernel.org):
> 
> - cid: drop leaked cpus_read_lock() on scx_cid_init() failure;
>    BUILD_BUG_ON tightened to NR_CPUS<=8192 to match the BPF cmask
>    helpers' CMASK_MAX_WORDS coverage.
> - bpf-struct-size: use offsetof() in struct_size() to match the
>    kernel <linux/overflow.h> macro semantics (no inflation from
>    trailing struct padding).
> - cmask: cmask_copy_from_kernel() validates src->base==0 via
>    probe-read; nr_bits check is bit-level rather than rounded-up
>    word-count.
> - cid-qmap-idle: qmap_init() refuses to load when scx_bpf_nr_cids()
>    exceeds SCX_QMAP_MAX_CPUS; the task_ctx flex array would otherwise
>    overflow into the next slab entry.
> 
> v2: https://lore.kernel.org/r/20260424172721.3458520-1-tj@kernel.org
> v1: https://lore.kernel.org/r/20260421071945.3110084-1-tj@kernel.org
> 
> This patchset introduces topological CPU IDs (cids) - dense,
> topology-ordered cpu identifiers - and an alternative cid-form struct_ops
> type that lets BPF schedulers operate in cid space directly.
> 
> Key pieces:
> 
> - cid space: scx_cid_init() walks nodes * LLCs * cores * threads and packs
>    a dense cid mapping. The mapping can be overridden via
>    scx_bpf_cid_override(). See "Topological CPU IDs" in ext_cid.h for the
>    model.
> 
> - cmask: a base-windowed bitmap over cid space. Kernel and BPF helpers with
>    identical semantics. Used by scx_qmap for per-task affinity and idle-cid
>    tracking; meant to be the substrate for sub-sched cid allocation.
> 
> - bpf_sched_ext_ops_cid: a parallel struct_ops type whose callbacks take
>    cids/cmasks instead of cpus/cpumasks. Kernel translates at the boundary
>    via scx_cpu_arg() / scx_cpu_ret(); the two struct types share offsets up
>    through @priv (verified by BUILD_BUG_ON) so the union view in scx_sched
>    works without function-pointer casts. Sub-sched support is tied to
>    cid-form: validate_ops() rejects cpu-form sub-scheds and cpu-form roots
>    that expose sub_attach / sub_detach.
> 
> - cid-form kfuncs: scx_bpf_kick_cid, scx_bpf_cidperf_{cap,cur,set},
>    scx_bpf_cid_curr, scx_bpf_task_cid, scx_bpf_this_cid,
>    scx_bpf_nr_{cids,online_cids}, scx_bpf_cid_to_cpu, scx_bpf_cpu_to_cid.
>    A cid-form program may not call cpu-only kfuncs (enforced at verifier
>    load via scx_kfunc_context_filter); the reverse is intentionally
>    permissive to ease migration.
> 
> - scx_qmap port: scx_qmap is converted to cid-form. It uses the cmask-based
>    idle picker, per-task cid-space cpus_allowed, and cid-form kfuncs
>    throughout. Sub-sched dispatching via scx_bpf_sub_dispatch() continues to
>    work.
> 
> v3 re-tested on the 16-cpu QEMU: cid-form scx_qmap under stress-ng plus
> reload cycles, hotplug auto-restart, and sub-sched (root scx_qmap +
> cgroup-scoped scx_qmap child). Clean.
> 
> Based on sched_ext/for-7.2 (4939721aad2e).
> 
>   0001-sched_ext-Add-ext_types.h-for-early-subsystem-wide-d.patch
>   0002-sched_ext-Rename-ops_cpu_valid-to-scx_cpu_valid-and-.patch
>   0003-sched_ext-Move-scx_exit-scx_error-and-friends-to-ext.patch
>   0004-sched_ext-Shift-scx_kick_cpu-validity-check-to-scx_b.patch
>   0005-sched_ext-Relocate-cpu_acquire-cpu_release-to-end-of.patch
>   0006-sched_ext-Make-scx_enable-take-scx_enable_cmd.patch
>   0007-sched_ext-Add-topological-CPU-IDs-cids.patch
>   0008-sched_ext-Add-scx_bpf_cid_override-kfunc.patch
>   0009-tools-sched_ext-Add-struct_size-helpers-to-common.bp.patch
>   0010-sched_ext-Add-cmask-a-base-windowed-bitmap-over-cid-.patch
>   0011-sched_ext-Add-cid-form-kfunc-wrappers-alongside-cpu-.patch
>   0012-sched_ext-Add-bpf_sched_ext_ops_cid-struct_ops-type.patch
>   0013-sched_ext-Forbid-cpu-form-kfuncs-from-cid-form-sched.patch
>   0014-tools-sched_ext-scx_qmap-Restart-on-hotplug-instead-.patch
>   0015-tools-sched_ext-scx_qmap-Add-cmask-based-idle-tracki.patch
>   0016-tools-sched_ext-scx_qmap-Port-to-cid-form-struct_ops.patch
>   0017-sched_ext-Require-cid-form-struct_ops-for-sub-sched-.patch
> 
> Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-cid-v3
> 
>   kernel/sched/build_policy.c              |   3 +
>   kernel/sched/ext.c                       | 651 ++++++++++++++++++++++++++----
>   kernel/sched/ext_cid.c                   | 409 +++++++++++++++++++
>   kernel/sched/ext_cid.h                   | 164 ++++++++
>   kernel/sched/ext_idle.c                  |   8 +-
>   kernel/sched/ext_internal.h              | 205 +++++++---
>   kernel/sched/ext_types.h                 | 104 +++++
>   tools/sched_ext/include/scx/cid.bpf.h    | 667 +++++++++++++++++++++++++++++++
>   tools/sched_ext/include/scx/common.bpf.h |  23 ++
>   tools/sched_ext/include/scx/compat.bpf.h |  24 ++
>   tools/sched_ext/scx_qmap.bpf.c           | 346 +++++++++-------
>   tools/sched_ext/scx_qmap.c               |  70 +++-
>   tools/sched_ext/scx_qmap.h               |   2 +-
>   13 files changed, 2391 insertions(+), 285 deletions(-)
> 
> Thanks.
> 
> --
> tejun
> 

