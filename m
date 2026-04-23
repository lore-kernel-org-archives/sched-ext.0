Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8262EB859
	for <sched-ext@lists.linux.dev>; Thu, 23 Apr 2026 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776937000; cv=none; b=UKBoAN55xXBQzcFoRO5/gPa7DVT9gPOPs/jGAYv1y5p37UO6lFzCj/jxyNv8q6Ue152jOBCIEiywuoB/8uF6UUlgaZiLg9aPvKhi7BXS4DoT7p2ErOuzkvjTZ6UVtIQEpsdQ/ER7/VGU3ZdwCx+Tgihrq7h7w+Gn/NtzwYLHh+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776937000; c=relaxed/simple;
	bh=9e2z8lbm+scoSSbWqfQThbD+HCaV12hpnnLMH41u1p8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=g9rBmo6WaxMVWadbqx3FH69gi6Pw9i+ywO3xGjbIM6c+/r8ji930DJLWK/2eVi5v+thKz62YP2HMbG898ZFL8I+ziuHI0nc7uG6tqaNyduciQE7VSDJeSvADiv9DyuyZOAiAnCVgUCU6f+8epny5d8KuWwu69zr180tAtGlqktI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=pN9pv/75; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="pN9pv/75"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=MIME-Version:Content-Type:Subject:From:To:Date:
	Message-Id; bh=PzNfz4ZNpZ6WeuX3TcZduhzxe7RdToCtJ0NkNO9MDSs=; b=p
	N9pv/75B0KL/jkY5mtGx6oQjX5UDGJgPVlhvYw7B/2Kpv2hnJ76gFm3zs9PS1/5n
	6gcH8fxPoBqq+6JTJTZssJrt1E0tdfSVe5PJQu7Zdy8zmIw4XLaL2M/PY0zrIDWe
	hXg1IHdo9x80cXhISb3NBTqb5O/1Lv+8tFAMsHvhnM=
Received: from [127.0.1.1] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgDn79bU5+lpaAhqDw--.53831S2;
	Thu, 23 Apr 2026 17:35:17 +0800 (CST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 12/16] sched_ext: Forbid cpu-form kfuncs from cid-form
 schedulers
From: Zhao Mengmeng <zhaomzhao@126.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: Zhao Mengmeng <zhaomzhao@126.com>, Tejun Heo <tj@kernel.org>, 
 void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
 sched-ext@lists.linux.dev, emil@etsalapatis.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260423171156.G698a@cchengyang.duckdns.org>
References: <20260421071945.3110084-1-tj@kernel.org>
 <20260421071945.3110084-13-tj@kernel.org>
 <177693500312.275653.17323765149266875001.b4-reply@b4>
 <20260423171156.G698a@cchengyang.duckdns.org>
Date: Thu, 23 Apr 2026 17:35:16 +0800
Message-Id: <177693691666.302051.8681445792423127931.b4-reply@b4>
X-Mailer: b4 0.15.2
X-CM-TRANSID:PykvCgDn79bU5+lpaAhqDw--.53831S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AFykJFy8XFy8uF48XFW5KFg_yoWxWFyfpF
	WvvF1qkr18Xa45Z3Z7tF4vqr1ftrs5tw4I9w4UGFySkwsFqayxJw1Svr45X3s5Crn2kw4D
	Zry0gFWfWr1Fy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRcBMtUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBlxUEe2np59V9TQAA3-

On 2026-04-23 17:21 +0800, Cheng-Yang Chou wrote:
> Hi Zhao,
> 
> On Thu, Apr 23, 2026 at 05:03:23PM +0800, Zhao Mengmeng wrote:
> > non_scx_kfunc_deny.bpf.c:17:6: error: conflicting types for 'scx_bpf_kick_cpu'
> > 17 | void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
> > |      ^
> > /root/work/source-code/linux-next/tools/testing/selftests/sched_ext/build/include/vmlinux.h:136300:13: note: previous declaration is here
> > 136300 | extern void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux *aux) __weak __ksym;
> > |             ^
> > non_scx_kfunc_deny.bpf.c:26:23: error: too few arguments to function call, expected 3, have 2
> > 26 |         scx_bpf_kick_cpu(0, 0);
> > |         ~~~~~~~~~~~~~~~~     ^
> > /root/work/source-code/linux-next/tools/testing/selftests/sched_ext/build/include/vmlinux.h:136300:13: note: 'scx_bpf_kick_cpu' declared here
> > 136300 | extern void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux *aux) __weak __ksym;
> > 
> > On the one hand, non_scx_kfunc_deny.bpf.c has it own problem, it should
> > not declare scx_bpf_kick_cpu(), on the other hand, the root cause is after
> 
> If your point is that a TCP program shouldn't declare scx_bpf_kick_cpu(),
> you are correct. The main goal of non_scx_kfunc_deny is to ensure that,
> witch commit 2d2b026c3ea7, no non-SCX programs can use SCX func.

No, I mean this bpf program can just `#include <scx/common.bpf.h>` at the
start of the file, remove the scx_bpf_kick_cpu() declaration.

diff --git a/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c b/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
index 9f16d39255e7..0d6fcc8e5eb6 100644
--- a/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
+++ b/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
@@ -9,12 +9,7 @@
* Copyright (C) 2026 Cheng-Yang Chou <yphbchou0911@gmail.com>
*/

-#include <vmlinux.h>
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-
-/* SCX kfunc from scx_kfunc_ids_any set */
-void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
+#include <scx/common.bpf.h>

SEC("struct_ops/ssthresh")
__u32 BPF_PROG(tcp_ca_ssthresh, struct sock *sk)

But before this commit, your code builds well, after this commit, it
failed. That's why I suggest Tejun to add the missing KF_IMPLICIT_ARGS, it
changed the signature in generated vmlinux.h, which I think we don't need
expose aux argument to bpf program.
> 
> > this commit, the signature of scx_bpf_kick_cpu() changes from
> > 
> > `extern void scx_bpf_kick_cpu(s32 cpu, u64 flags) __weak __ksym;` to
> > `extern void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux *aux) __weak __ksym` 
> 
> Regarding the non_scx_kfunc_deny.bpf.c build failure, I'll fix it. If
> needed, we can test with another SCX function that doesn't require the
> *aux parameter.
> 
> Thanks.

Like I said above, it builds well on for-next branch, just this commit
trigger the failure. I believe your test case is very reasonable.

Best regards,
--  
Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> > 
> > After code analysis and test, I believe scx_bpf_kick_cpu miss the 
> > KF_IMPILCIT_ARGS, just like the defination in scx_kfunc_ids_any.
> > 
> > So here misses  KF_IMPLICIT_ARGS 
> > > +BTF_ID_FLAGS(func, scx_bpf_task_cpu)
> > Missing KF_RCU.
> > > +BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
> > Missing KF_IMPLICIT_ARGS
> > > +BTF_ID_FLAGS(func, scx_bpf_cpu_curr)
> > Missing KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED
> > > +BTF_ID_FLAGS(func, scx_bpf_cpu_node)
> > > +BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap)
> > Missing KF_IMPLICIT_ARGS
> > > +BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur)
> > Missing KF_IMPLICIT_ARGS
> > > +BTF_ID_FLAGS(func, scx_bpf_cpuperf_set)
> > Missing KF_IMPLICIT_ARGS
> > > +BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask)
> > Missing KF_ACQUIRE
> > > +BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask)
> > Missing KF_ACQUIRE
> > > +BTF_ID_FLAGS(func, scx_bpf_put_cpumask)
> > Missing KF_RELEASE
> > > +BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl)
> > Missing KF_IMPLICIT_ARGS | KF_RCU
> > > +BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and)
> > Missing KF_IMPLICIT_ARGS | KF_RCU
> > > +BTF_ID_FLAGS(func, scx_bpf_select_cpu_and)
> > Missing KF_RCU
> > 
> > Please correct me if I miss something.
> > > +BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask)
> > > +BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask_node)
> > > +BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask)
> > > +BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask_node)
> > > +BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask)
> > > +BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
> > > +BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu)
> > > +BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node)
> > > +BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu)
> > > +BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu_node)
> > > +BTF_KFUNCS_END(scx_kfunc_ids_cpu_only)
> > > +
> > >  /*
> > >   * Per-op kfunc allow flags. Each bit corresponds to a context-sensitive kfunc
> > >   * group; an op may permit zero or more groups, with the union expressed in
> > > @@ -10031,6 +10067,7 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
> > >  	bool in_cpu_release = btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id);
> > >  	bool in_idle = btf_id_set8_contains(&scx_kfunc_ids_idle, kfunc_id);
> > >  	bool in_any = btf_id_set8_contains(&scx_kfunc_ids_any, kfunc_id);
> > > +	bool in_cpu_only = btf_id_set8_contains(&scx_kfunc_ids_cpu_only, kfunc_id);
> > >  	u32 moff, flags;
> > >  
> > >  	/* Not an SCX kfunc - allow. */
> > > @@ -10068,6 +10105,15 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
> > >  	    prog->aux->st_ops != &bpf_sched_ext_ops_cid)
> > >  		return -EACCES;
> > >  
> > > +	/*
> > > +	 * cid-form schedulers must use cid/cmask kfuncs. cid and cpu are both
> > > +	 * small s32s and trivially confused, so cpu-only kfuncs are rejected at
> > > +	 * load time. The reverse (cpu-form calling cid-form kfuncs) is
> > > +	 * intentionally permissive to ease gradual cpumask -> cid migration.
> > > +	 */
> > > +	if (prog->aux->st_ops == &bpf_sched_ext_ops_cid && in_cpu_only)
> > > +		return -EACCES;
> > > +
> > >  	/* SCX struct_ops: check the per-op allow list. */
> > >  	if (in_any || in_idle)
> > >  		return 0;
> > > -- 
> > > 2.53.0
> > > 
> > > 
> > 
> > 
> > 
> 
> -- 
> Cheers,
> Cheng-Yang
> 


