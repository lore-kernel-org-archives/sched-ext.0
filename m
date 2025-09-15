Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689DB2D5410;
	Mon, 15 Sep 2025 07:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920957; cv=none; b=Qkfb4+VxdlqX5xzNWZT4knKs138Q/crapECE8J0k40RsRAWFnueGzp2JXFBTQh0KlMqvSR4L8jNRGBdjYtT4BNosShnh1chMyVzuTiqRM39Mp14prbKHlcahJrbBt7uUu3/ENqnACzjW36uJi7170a99NRJY7H9GBV+8IUJUgcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920957; c=relaxed/simple;
	bh=6GpWF7++CGjGvUkG7uSpyCjVeorJthApNUA9/W3UTKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWTqjVleLVqziEfPYR999/oHo8CUbbexIlV1taAnxMHziU3KhZ4cP71bMBmAEMjzJ4S9kbEc7ZCvafd3eXBRr1atz5QP0TuZBPhJzqT02ZLWsVOtGmsH1pWVTpMauurELyprq5RIiLlwMjrF4ZnDgE6Coykc/19fMU8HLkuR5n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=iOPf0TX/; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iOPf0TX/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f3Vzsf0SHsz53w/fRj6/iu+ZGqGrPOJgnz+3y2sYnCQ=; b=iOPf0TX/RVhtW0Js/XsIhpZejg
	F8QTYCaXx7L2ew1fEQZh3NQkbSb74csI4cR9PaT3SC5dBKXyRRdVdTFcesfEy5mlAY5CsKUv8lQwG
	tRm2IdBt4ucUYMvc1SDVWCwNkBJlktGL3+JasHCrF8amarR3M2BfoDFqMlNBJpL4DebCOVCNjZOxQ
	dUDo4zw9aU+TRmRzWgaNIEFjwMjfCQI5E2BwAzqDoyKuEZtGkXrAwTSRBeBVh+239n7v5nf8469zg
	/b1GM29lB1vfxXDslobYljlOFr92Qe9bgbMJf4LK7pP9DC9KwXovYwvhUhGVcHiBcCS+OdthCF3L3
	5zR4nBDQ==;
Received: from [58.29.143.236] (helo=[192.168.1.7])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uy3Xe-00BhZ3-RP; Mon, 15 Sep 2025 09:22:27 +0200
Message-ID: <978215f1-40d1-4c77-b436-2710029d5acc@igalia.com>
Date: Mon, 15 Sep 2025 16:22:20 +0900
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "sched_ext: Skip per-CPU tasks in
 scx_bpf_reenqueue_local()"
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250912161438.529446-1-arighi@nvidia.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20250912161438.529446-1-arighi@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andrea,

On 9/13/25 01:14, Andrea Righi wrote:
> scx_bpf_reenqueue_local() can be called from ops.cpu_release() when a
> CPU is taken by a higher scheduling class to give tasks queued to the
> CPU's local DSQ a chance to be migrated somewhere else, instead of
> waiting indefinitely for that CPU to become available again.
> 
> In doing so, we decided to skip migration-disabled tasks, under the
> assumption that they cannot be migrated anyway.
> 
> However, when a higher scheduling class preempts a CPU, the running task
> is always inserted at the head of the local DSQ as a migration-disabled
> task. This means it is always skipped by scx_bpf_reenqueue_local(), and
> ends up being confined to the same CPU even if that CPU is heavily
> contended by other higher scheduling class tasks.
> 
> As an example, let's consider the following scenario:
> 
>   $ schedtool -a 0,1, -e yes > /dev/null
>   $ sudo schedtool -F -p 99 -a 0, -e \
>     stress-ng -c 1 --cpu-load 99 --cpu-load-slice 1000
> 
> The first task (SCHED_EXT) can run on CPU0 or CPU1. The second task
> (SCHED_FIFO) is pinned to CPU0 and consumes ~99% of it. If the SCHED_EXT
> task initially runs on CPU0, it will remain there because it always sees
> CPU0 as "idle" in the short gaps left by the RT task, resulting in ~1%
> utilization while CPU1 stays idle:
> 
>      0[||||||||||||||||||||||100.0%]   8[                        0.0%]
>      1[                        0.0%]   9[                        0.0%]
>      2[                        0.0%]  10[                        0.0%]
>      3[                        0.0%]  11[                        0.0%]
>      4[                        0.0%]  12[                        0.0%]
>      5[                        0.0%]  13[                        0.0%]
>      6[                        0.0%]  14[                        0.0%]
>      7[                        0.0%]  15[                        0.0%]
>    PID USER       PRI  NI  S CPU  CPU%▽MEM%   TIME+  Command
>   1067 root        RT   0  R   0  99.0  0.2  0:31.16 stress-ng-cpu [run]
>    975 arighi      20   0  R   0   1.0  0.0  0:26.32 yes
> 
> By allowing scx_bpf_reenqueue_local() to re-enqueue migration-disabled
> tasks, the scheduler can choose to migrate them to other CPUs (CPU1 in
> this case) via ops.enqueue(), leading to better CPU utilization:
> 
>      0[||||||||||||||||||||||100.0%]   8[                        0.0%]
>      1[||||||||||||||||||||||100.0%]   9[                        0.0%]
>      2[                        0.0%]  10[                        0.0%]
>      3[                        0.0%]  11[                        0.0%]
>      4[                        0.0%]  12[                        0.0%]
>      5[                        0.0%]  13[                        0.0%]
>      6[                        0.0%]  14[                        0.0%]
>      7[                        0.0%]  15[                        0.0%]
>    PID USER       PRI  NI  S CPU  CPU%▽MEM%   TIME+  Command
>    577 root        RT   0  R   0 100.0  0.2  0:23.17 stress-ng-cpu [run]
>    555 arighi      20   0  R   1 100.0  0.0  0:28.67 yes
> 
> It's debatable whether per-CPU tasks should be re-enqueued as well, but
> doing so is probably safer: the scheduler can recognize re-enqueued
> tasks through the %SCX_ENQ_REENQ flag, reassess their placement, and
> either put them back at the head of the local DSQ or let another task
> attempt to take the CPU.
> 
> This also prevents giving per-CPU tasks an implicit priority boost,
> which would otherwise make them more likely to reclaim CPUs preempted by
> higher scheduling classes.
> 
> Fixes: 97e13ecb02668 ("sched_ext: Skip per-CPU tasks in scx_bpf_reenqueue_local()")
> Cc: stable@vger.kernel.org # v6.15+
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>   kernel/sched/ext.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 236dce2fc13b4..4c3592e26ee45 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5726,12 +5726,8 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(void)
>   		 * CPUs disagree, they use %ENQUEUE_RESTORE which is bypassed to
>   		 * the current local DSQ for running tasks and thus are not
>   		 * visible to the BPF scheduler.
> -		 *
> -		 * Also skip re-enqueueing tasks that can only run on this
> -		 * CPU, as they would just be re-added to the same local
> -		 * DSQ without any benefit.
>   		 */
> -		if (p->migration_pending || is_migration_disabled(p) || p->nr_cpus_allowed == 1)
> +		if (p->migration_pending)
>   			continue;

I think it is okay to keep "p->nr_cpus_allowed == 1" to the
condition. When a task is pinned to a *single* CPU, there is no
other place for a scheduler to put the task. Additionally, adding
the condition is acceptable in your example of the first task
running on either CPU 0 or 1.

Regards,
Changwoo Min
