Received: from outbound.qs.icloud.com (qs-2004j-snip4-4.eps.apple.com [57.103.84.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C582F47C11A
	for <sched-ext@lists.linux.dev>; Mon,  5 Oct 2026 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.84.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791199865; cv=none; b=Vj7lvTCjWtRBxVJIUdaXlXIp0t8tG9MKeHqMs42fA43Ujg/bx0dNbf1TN0X3S83oxD0N2GN6hJitzc6h8tiN28xKcceYkk5qqW5wEc7Zt+OYw0kC5vkFTqHNGnf5Rnj+q8eZb0oGLUuVfxOJqyy2tYDg6FqYZ2dmO/hiN1oYiwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791199865; c=relaxed/simple;
	bh=e8jgra+3c6etf+f1IV+hDahnaTLE+D8VuGRWF+MPfYY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gPSnQSjrPlrp25mq4B7xTvDLwmeMtjZSlhKOkg9oWObYQfi3OHCCHZThJe/VbTl7fZGS9PbPOYIuhvAjI1pvwAahIvvgRMdETVWzdaAqjRJH4EJnUHXCggdy1Gr02CBIaoL67TXu2CfTtEJ8aGsDOStfr4u5l5OPrG2eqIf+Y+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=rB0XH3KG; arc=none smtp.client-ip=57.103.84.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verdict.gg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b="rB0XH3KG"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-100-percent-1 (Postfix) with ESMTPS id A2086180013B;
	Mon, 05 Oct 2026 11:30:56 +0000 (UTC)
X-ICL-RepId: 01a10bd4-c701-74a7-933c-cd54c9c5d69d
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQBIHVwCXRxCCk0dXwdaEhVdRVcIWwJAEVc4RQhFD1sTTVZUChcNVk1PHUEJXghGXl4fEx9UVgBBGRBWAVhWXQVNGlwYWQ8cAUpWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNTx1BCV4IRl5eHxMAXg8PTH00ZDt0OXYqcktrJhlaeDcMMgZabjpkQG8xcxtSGVYZWgwdClBVEgRACFZQVB5BBFYVbAlYBlMZVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1791199861; x=1793791861; bh=OZRWUngntJZLR2dzkgMqR7G6fJ9N6gQT7CyHoAl8Oxs=; h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:x-icloud-hme; b=rB0XH3KGWWHr/bxoFcMUbw1TsifsaeuVMrv6uUqPBYRoDXqB3p+hkYUv/JVcrpLVHgHjV/nj5XjH6IRzscEvC8HrbVY+qujgNdrYioqn2M7CqgzmCgD9peqmnHGfAQmGt0mgpDboG+LnS5n/sgwihosRihY3wVMwIfFlaOORhOkgojr8Ev4kVWSOlE2hXdJ3NXYs+xzI+a1XCWD/h9Qm9CVzLVsTEEmOm+e8mOmakjiLzIRqYApfUC0D8Z8ILL8bd+AiqtlvgeOUGKi7vvDSknHysJfB230euVDiypGIbmwByia1ZV54XT67QGVnLpSQcyThDZW8xU/l/j5a+a69zw==
mail-alias-created-date: 1621344842221
Received: from localhost (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-100-percent-1 (Postfix) with ESMTPSA id 5AE7218001E2;
	Mon, 05 Oct 2026 11:30:52 +0000 (UTC)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Oct 2026 14:30:50 +0300
Message-Id: <DLWVCRDZK3XK.1JG5J57YQV0VI@verdict.gg>
Cc: "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra"
 <peterz@infradead.org>, "Juri Lelli" <juri.lelli@redhat.com>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, "Dietmar Eggemann"
 <dietmar.eggemann@arm.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Ben
 Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>, "Valentin
 Schneider" <vschneid@redhat.com>, "K Prateek Nayak"
 <kprateek.nayak@amd.com>, "Vladimir Vdovin" <deliran@verdict.gg>, "Emil
 Tsalapatis" <etsal@meta.com>, "Christian Loehle"
 <christian.loehle@arm.com>, "Balbir Singh" <balbirs@nvidia.com>, "Lee
 Trager" <ltrager@nvidia.com>, <sched-ext@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] sched_ext: Scan NUMA hinting faults for opted-in
 BPF schedulers
From: "Vladimir Vdovin" <deliran@verdict.gg>
To: "Andrea Righi" <arighi@nvidia.com>, "Tejun Heo" <tj@kernel.org>, "David
 Vernet" <void@manifault.com>, "Changwoo Min" <changwoo@igalia.com>
X-Mailer: aerc 0.22.0
References: <20261004072901.3579967-1-arighi@nvidia.com>
 <20261004072901.3579967-4-arighi@nvidia.com>
In-Reply-To: <20261004072901.3579967-4-arighi@nvidia.com>
X-Proofpoint-GUID: -KWyMyzycgyDDQNTQ0UfnRK6tOoVr5ks
X-Authority-Info-Out: v=2.4 cv=YfqwJgRf c=1 sm=1 tr=0 ts=6ac38a73
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8
 a=tddDIH3rDediNtISCcgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0NCBTYWx0ZWRfX8z4ltgwI2vzf
 Lrt9uH992UprJkHc/vfPLU8QDJkimmvp2Me7hxSwbesMhzs8YbhRgVK8eS9LrvpFhc8YkWfAmBF
 iwk630YKffHcCluQUpz+nVgeMyNy7i6bFm8/RHO2jepEquGf2zFrJLt+JLJWSniOsmSQ9puRP0+
 52TzDIYGItF6xmUc8MgLAKiCW/UVuZqATTZJC7Njbjv113x2XAU1B6b+VQjvS9ubi9JHZY9CDjn
 6kaNrmMx3TrgjWtDtbevCWRNiVBLZsgnLRSEL60wlt+S5ciCbo+kKrSB7ErN1ZhaaYEeTudDttM
 PrKoRxfEY3a+Sj3QipxhKQFeRx4lzervXGTfS/ef/8VI9ZskORDfXU53WJhCxw=
X-Proofpoint-ORIG-GUID: -KWyMyzycgyDDQNTQ0UfnRK6tOoVr5ks
X-JNJ: AAAAAAABzjPO6W4rny0V0o6bNlMjhh9AgF0wCO0Am2j5gnoKqV0Cu/ano5uoylOeo1Rs+Dx4cqzL8WIIxfcOpqG/N8yvS/4n3brLBFzmfnNryaheFrRBibwuwJdz1xZ3bjmrRBoqaB6mJODb9Xt9teDUB3UeavBAoICnHVO2Dtd/9O1r3tRWcuXBSyY9aLT3u9Wt/SsQgRPjVu7NjcionUMW+8Hyso8/jT6gUc0Heoq+pPtgm4kwcx/3e6R2/Z9WRyJL2IY51KPff0RFJDBmKpxecW7I7TkEHl40iiP+sW4vx5erQCszzwfLme+PBAx2HIJdwsKUBpRJ5K6jVVLJrpyQa01LNR+s3NSoAByiRecbENvyqiKT23aynHJLZh5KvIHsO6veTnp2YSxFeIpBOENY7lSpnigDFyMo3Z9UW2l776Nj6RJBu/wluvvPGxGk6OI5uNj5atWaMEnHn+9WxZ0p/h3QzTLni2KdAzaSfUEZaw1++At6pc2AXMu3oNYXbMjEizYkQMj62iDgxyMIS0Hzi1Z9i+EuhAPXjGOZip/rUNnbVG5wYfiYEtTGJB8q/C+/s+4ufdEyN1hon0lzP5dBe8hYf629CUwhM1iUP9d6ceXW4MpKoOwZRISFuUAVTy2KteMQL2//i/jiTicdaRTxB5YrtfXkgl8ifX7C7e2Rn8P0GPqgQi40SHioE0cdZL062DpzJsETXFY7uk7SC6aDU+y3pc6recUwQ7kSEloPhZmFOcCJLSrlSivaORAkDx2x5YwVfZubSYAjlqLOUfpvdY9FRLtHmNMn1jVec1pdmjS2+ml85oE3g23tcJUOXu0hNjrGarRQ9gFEWGk8fOd5dpvrz1JYDhjU3lhn+TKssWySXbFxYUct3kdpI9czTwSt1r42nMOj/45aM1ZXoAunBvNhwMorunu+mpH73Aev2oJJ9+8dQG5NYQ0CeudfbxWpKQLd4wVd/8yP1VYAVsJ2I6XdIPq
 df5YPQB++nYe55OEDCA9X99tGi4jPp6NIKKPxbzQuquuXHg0VAPMwMAX4TI0Q7rvsJD8RDYSbZpMsO9JIRMnQUwKXmX+FuK+sZ88xHgxJTw1GUkoQ5jwyIdAhykYWvb+PNKPP6Qf3alrtimFj4/u0MjBcqYXSQ5K0otugtZqiyp7rZhjQJ5f7J1dn/IuOqHiY+1Cagvv6/takYeeJFhpuLogFyL3Ln9lh1TUOT8IeM1zsTuzEF1smSXRGGv7OVbFD39TwHrvl1mkqCfcGc/bp7KtQ69imu30GJ1ve7tmbt/F7952d4KW6cnjn9YQMv9BUm7mNzxLIef4AHtqQai5v/zJAMGszI+XoALz97l8pExRZKS59sjfY1pnGGCodQBYpK0g/m5OOOqzH3DR1zQNv/ydGMTuGFd9fz/lObByKxfA/OJGcy+umUItOdSpk3x9FkEN1iulYkFF48xkxUaCIKcavq0DsL+17ZEKoBxl8tHZPzQYm5baO+b6cFbOEhP0zrqM=

Hi Andrea,

Thanks for putting this together so quickly, and for picking up the RFC.

On Sun, Oct 04, 2026 at 09:27:09AM +0200, Andrea Righi wrote:
> +   if (!queued && (sch->ops.flags & SCX_OPS_NUMA_BALANCING) &&
> +       static_branch_unlikely(&sched_numa_balancing))
> +           task_tick_numa(rq, donor);

One question about proxy execution, which I may well be missing context
on. Hui Su's tick series moves the fair NUMA tick to the execution
context, with the reasoning that task_tick_numa() works on the mm and
NUMA work state of the task that is actually running:

  https://lore.kernel.org/r/20260909092901.2989564-3-sh_def@163.com

Here the scan is driven from the donor. I understand that in your proxy
execution integration SCX runtime is accounted to the donor, so maybe
this is intentional to keep the pacing consistent, but then the scan
would cover the donor's address space rather than the one being
accessed. Is the donor the intended choice here, or should this follow
rq->curr once SCHED_PROXY_EXEC no longer depends on !SCHED_CLASS_EXT?

Thanks,
Vladimir
