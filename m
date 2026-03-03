Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F145282F09
	for <sched-ext@lists.linux.dev>; Tue,  3 Mar 2026 02:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772505107; cv=none; b=rdt7toAyU6p0Wm5ssBkmKqhdyPWx0XBImYYLNThxNUg4rPTp6wIEDS4J74Iq9wxL5f/Zz4HJ/gDV/BrbwY5iyrguouAnNXvtP3p3XQhb+0R8rIfF9SqNSH7ZlIhMQdDqgcUzsoegRoZv0qayxdlbRssbm5ifWXg4gxBaJabcltM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772505107; c=relaxed/simple;
	bh=JzNrP9tvHInr9SBXJ9N7v1S9tT5FRYcssavAKfUhScQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IvEgJP6X2D7abRsIB+2w+f8OZSVE4q7+OD1KWUDd2DpRvveCltn648pNtThC/J5UPXRGAjyud0S3HWmZllSP98PRqzoankBLnUw1y6YlCl//LDRnF4RsJ1+DLy3tEgYVbpH2ihggvIXoqx6kjxzuR9PostAYgMTwIdtzxY2WGrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mCNKguod; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mCNKguod"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=40
	eoCfJYFRYAYBkfXxMoQX0zv97M5AIQLP2RZTzvyNs=; b=mCNKguodqfkbstEv45
	PiqlpUdgGN0yXN3Rw4ON1AmgFghZcuuHhHoE5A3nHsEwDba/QUEOweHMwFrqtCwt
	c4rzrD/AtNIxsTJbPtp2DKlzj5XVQMaU7M6k154wrU9Nz/9pOwwuuESMW2LmUGhB
	A2ZE9ZW6HP32XroxzEsL8WAgI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wA3AIH9R6ZpYLR8Ow--.535S2;
	Tue, 03 Mar 2026 10:31:27 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: arighi@nvidia.com
Cc: changwoo@igalia.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	sched-ext@lists.linux.dev,
	shuah@kernel.org,
	tj@kernel.org,
	void@manifault.com,
	yangfeng59949@163.com
Subject: Re: [PATCH] selftests/sched_ext: Fix the incorrect logic validation
Date: Tue,  3 Mar 2026 10:31:25 +0800
Message-Id: <20260303023125.80568-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <aaWqNx-DDtzzSqW6@gpd4>
References: <aaWqNx-DDtzzSqW6@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3AIH9R6ZpYLR8Ow--.535S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr1xKFW8Ww15JryxCr4DJwb_yoWruw4kpa
	48ua9I9F1DtF13K3y2yr4ktrWFgwn3tan7uw4UJ3W3AF1kWF1xJr1kKr15W3s3ur4vkF1f
	ZF1vgayxWF48A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU3DGnUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbCzx8VjWmmR-8AzAAA3z

Hi Andrea,

On Mon, 2 Mar 2026 16:18:15 +0100, Andrea Righi wrote:
> Hi Feng,
> 
> On Mon, Mar 02, 2026 at 04:41:30PM +0800, Feng Yang wrote:
> > On Mon, 2 Mar 2026 08:47:17 +0100, Andrea Righi wrote:
> > > On Mon, Mar 02, 2026 at 02:48:51PM +0800, Feng Yang wrote:
> > > > From: Feng Yang <yangfeng@kylinos.cn>
> > > > 
> > > > When __COMPAT_scx_bpf_pick_idle_cpu_node selects an idle CPU,
> > > > it reports that the CPU should be marked as busy.
> > > > 
> > > > Fixes: 5ae5161820e5 ("selftests/sched_ext: Add NUMA-aware scheduler test")
> > > > Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> > > > ---
> > > >  tools/testing/selftests/sched_ext/numa.bpf.c | 8 ++++----
> > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/tools/testing/selftests/sched_ext/numa.bpf.c b/tools/testing/selftests/sched_ext/numa.bpf.c
> > > > index a79d86ed54a1..98423628b05c 100644
> > > > --- a/tools/testing/selftests/sched_ext/numa.bpf.c
> > > > +++ b/tools/testing/selftests/sched_ext/numa.bpf.c
> > > > @@ -44,12 +44,12 @@ s32 BPF_STRUCT_OPS(numa_select_cpu,
> > > >  	 */
> > > >  	cpu = __COMPAT_scx_bpf_pick_idle_cpu_node(p->cpus_ptr, node,
> > > >  					__COMPAT_SCX_PICK_IDLE_IN_NODE);
> > > > -	if (cpu < 0)
> > > > +	if (cpu < 0) {
> > > >  		cpu = __COMPAT_scx_bpf_pick_any_cpu_node(p->cpus_ptr, node,
> > > >  						__COMPAT_SCX_PICK_IDLE_IN_NODE);
> > > > -
> > > > -	if (is_cpu_idle(cpu, node))
> > > > -		scx_bpf_error("CPU %d should be marked as busy", cpu);
> > > > +		if (is_cpu_idle(cpu, node))
> > > > +			scx_bpf_error("CPU %d should be marked as busy", cpu);
> > > > +	}
> > > 
> > > No, this is not correct. The CPU returned by scx_bpf_pick_idle_cpu_node()
> > > should be marked as busy at this point (bit is set in the idle cpumask),
> > > essentially it has been reserved/allocated by the caller.
> > 
> > Okay, I misunderstood.
> > The CI test of this patch (https://patchwork.kernel.org/project/netdevbpf/list/?series=1058866&state=*) 
> > resulted in the error "CPU 0 should be marked as busy"(https://github.com/kernel-patches/bpf/actions/runs/22548310848/job/65314767856),
> > but I don't see the connection between them that would cause this error. Could you explain why this happens?
> 
> The is_cpu_idle() test is going to be always a bit flaky in some cases,
> for what I see we may have two races:
> 
> 1) if the first call to scx_bpf_pick_idle_cpu_node() returns a negative
>    value, we fallback to "pick any CPU". Between selecting the CPU and
>    checking if it's idle, the task running on the CPU may have released it,
>    allowing the idle task to run and set the idle bit again.
> 
> 2) Even if the first scx_bpf_pick_idle_cpu_node() returns a cpu >= 0, that
>    CPU might still execute a short-lived task, which then releases it and
>    sets the idle bit again.
> 
> Given this, I think the most reliable approach is to remove the
> is_cpu_idle() check here to avoid flakiness and instead implement something
> along the lines of the following. What do you think?

That sounds like a good solution. 
Do I still need to submit the patch for this new approach?

Thanks,
-Feng

> Thanks,
> -Andrea
> 
>  tools/testing/selftests/sched_ext/numa.bpf.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/sched_ext/numa.bpf.c b/tools/testing/selftests/sched_ext/numa.bpf.c
> index a79d86ed54a1b..209dacdbd117e 100644
> --- a/tools/testing/selftests/sched_ext/numa.bpf.c
> +++ b/tools/testing/selftests/sched_ext/numa.bpf.c
> @@ -19,18 +19,6 @@ UEI_DEFINE(uei);
>  
>  const volatile unsigned int __COMPAT_SCX_PICK_IDLE_IN_NODE;
>  
> -static bool is_cpu_idle(s32 cpu, int node)
> -{
> -	const struct cpumask *idle_cpumask;
> -	bool idle;
> -
> -	idle_cpumask = __COMPAT_scx_bpf_get_idle_cpumask_node(node);
> -	idle = bpf_cpumask_test_cpu(cpu, idle_cpumask);
> -	scx_bpf_put_cpumask(idle_cpumask);
> -
> -	return idle;
> -}
> -
> s32 BPF_STRUCT_OPS(numa_select_cpu,
>  		   struct task_struct *p, s32 prev_cpu, u64 wake_flags)
>  {
> @@ -44,12 +32,12 @@ s32 BPF_STRUCT_OPS(numa_select_cpu,
>  	 */
>  	cpu = __COMPAT_scx_bpf_pick_idle_cpu_node(p->cpus_ptr, node,
>  					__COMPAT_SCX_PICK_IDLE_IN_NODE);
> -	if (cpu < 0)
> +	if (cpu < 0) {
>  		cpu = __COMPAT_scx_bpf_pick_any_cpu_node(p->cpus_ptr, node,
>  						__COMPAT_SCX_PICK_IDLE_IN_NODE);
> -
> -	if (is_cpu_idle(cpu, node))
> -		scx_bpf_error("CPU %d should be marked as busy", cpu);
> +		if (cpu < 0)
> +			return prev_cpu;
> +	}
>  
>  	if (__COMPAT_scx_bpf_cpu_node(cpu) != node)
>  		scx_bpf_error("CPU %d should be in node %d", cpu, node);
> 

