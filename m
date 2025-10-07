Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF55011712;
	Tue,  7 Oct 2025 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759854525; cv=none; b=fAEQDukv/eX6v8PCz+1K+KcbR/xdyAgpGDfys06eskdDY1eNFg+10crITVSqSrvDfQLN+HmjgRFCqSwGUU0Q3IONM56E82rDJYKuYg1Z1YXsn9TRX31X7vp1ANpqY7CplQmap6Jzh73+FD00B9a8+zBmYC/VPi/6yja0/jS7fT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759854525; c=relaxed/simple;
	bh=kEutHGL8JzmVi3dQ2UbN4yiTCki5tznW7ZmLxi+fP3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBlbM/ch0LO4Fbtjem5k1EQ5YTi354mlgeJDXYyTGwAIrJznOWcE+15MN3P1IiezldVzpCpmvEpV2HQ1HpFHbVWm4pXKPYYOlHjIuXtK8eYxXAqMChR0Adb2UR8trjRE91NndGCUKwT0G40KK1wHGkGHrdDwIjxN1WkqGrODhNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cFw/JAVu; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cFw/JAVu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ta4UZH7jWmaJh0s9qTr64RQ98ewcCcpeSGfpr9Lk/00=; b=cFw/JAVu9NrYgxn4FewF4VA99Y
	7ZvlemE2fUSHf0OEoIGLDlN55vV2xdfeiTkHGScvN09zeWiEn5mp9ppr+68ug1kwQB3X5pgl3n6yX
	W06bnTlag9j9TuTS9FCWPVDPlXebGvAugJMx+SHDPYQNOfPcWeWp3tG6X4/CKX0/N5Pz8w8FLu8cz
	0/l2ApDg5zucCEb5SIh/4GXQ0MJKeRcsa5wK0wlMvWxer99pKM8AjvFnTdqw6CnMJi/UcFg8/p/62
	nMftDIdTY6J9Qq+JqL1neJycC07vuLgmfh14vz3+sm9khmZTSk/T6xgG4HknRxNA3cK/9hxaoyecO
	1bpYvN4A==;
Received: from [58.29.143.236] (helo=[192.168.1.7])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1v6AYF-006H1f-DV; Tue, 07 Oct 2025 18:28:35 +0200
Message-ID: <f841e330-d490-4912-b817-76c337cad6fe@igalia.com>
Date: Wed, 8 Oct 2025 01:28:31 +0900
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] sched_ext: Add scx_bpf_task_set_slice() and
 scx_bpf_task_set_dsq_vtime()
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
References: <20251007015147.2496026-1-tj@kernel.org>
 <20251007015147.2496026-3-tj@kernel.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20251007015147.2496026-3-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/7/25 10:51, Tejun Heo wrote:
> With the planned hierarchical scheduler support, sub-schedulers will need to
> be verified for authority before being allowed to modify task->scx.slice and
> task->scx.dsq_vtime. Add scx_bpf_task_set_slice() and
> scx_bpf_task_set_dsq_vtime() which will perform the necessary permission
> checks.

Is it necessary to distinguish between decreasing the slice and
increasing the slice? A BPF scheduler (e.g., LAVD) sets the slice to
zero for passive preemption.

Regards,
Changwoo Min

> 
> Root schedulers can still directly write to these fields, so this doesn't
> affect existing schedulers.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>   kernel/sched/ext.c                       | 30 ++++++++++++++++++++++++
>   tools/sched_ext/include/scx/common.bpf.h |  2 ++
>   2 files changed, 32 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index fc353b8d69f7..6d76efaaa9b2 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5833,6 +5833,34 @@ static const struct btf_kfunc_id_set scx_kfunc_set_unlocked = {
>   
>   __bpf_kfunc_start_defs();
>   
> +/**
> + * scx_bpf_task_set_slice - Set task's time slice
> + * @p: task of interest
> + * @slice: time slice to set in nsecs
> + *
> + * Set @p's time slice to @slice. Returns %true on success, %false if the
> + * calling scheduler doesn't have authority over @p.
> + */
> +__bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice)
> +{
> +	p->scx.slice = slice;
> +	return true;
> +}
> +
> +/**
> + * scx_bpf_task_set_dsq_vtime - Set task's virtual time for DSQ ordering
> + * @p: task of interest
> + * @vtime: virtual time to set
> + *
> + * Set @p's virtual time to @vtime. Returns %true on success, %false if the
> + * calling scheduler doesn't have authority over @p.
> + */
> +__bpf_kfunc bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime)
> +{
> +	p->scx.dsq_vtime = vtime;
> +	return true;
> +}
> +
>   static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
>   {
>   	struct rq *this_rq;
> @@ -6638,6 +6666,8 @@ __bpf_kfunc void scx_bpf_events(struct scx_event_stats *events,
>   __bpf_kfunc_end_defs();
>   
>   BTF_KFUNCS_START(scx_kfunc_ids_any)
> +BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_RCU);
> +BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_RCU);
>   BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
>   BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
>   BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index 06e2551033cb..505231b7b7ae 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -102,6 +102,8 @@ s32 scx_bpf_pick_any_cpu_node(const cpumask_t *cpus_allowed, int node, u64 flags
>   s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
>   bool scx_bpf_task_running(const struct task_struct *p) __ksym;
>   s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
> +bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice) __ksym __weak;
> +bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime) __ksym __weak;
>   struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
>   struct rq *scx_bpf_locked_rq(void) __ksym;
>   struct task_struct *scx_bpf_cpu_curr(s32 cpu) __ksym __weak;

