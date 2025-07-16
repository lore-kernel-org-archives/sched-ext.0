Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7A92F5308
	for <sched-ext@lists.linux.dev>; Wed, 16 Jul 2025 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670482; cv=none; b=Rmp1otWlKXxGepFWiq68udtdL4/FKn8717WPj5gc5GdGQ0VVQwH87kXZHrsOASnGZ27M/+5k1456EVnM/E92WXb4fKqSD9a8mUJHkh04W1KuBoCPxBl3cfg7uffHsuf7sqG89yyGi3EW4OsnEfcmkaEtLsuLM07JubB+UOmyy4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670482; c=relaxed/simple;
	bh=nBFtaQVvD8Z1f+t4c2aOVAFPBmeOIuqesSj5OuCdDzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyPPSdXFMEm+HwY2RJUiO6gBLJzrhEmdzA2bys/kmqv9Lp4y+vfu9MuLHkgkTT/BeIiXU28z99TkBReM3Kiz8xT+tndjVzfsoEiCF34UsfEq9waKxyTv45RQPSW0RWwx/FD8hhVC3LyVF/3V1Wg+G8s70DsbtvEZhzoa/tjg3cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id A587D10F862;
	Wed, 16 Jul 2025 12:54:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id EAD222002C;
	Wed, 16 Jul 2025 12:54:28 +0000 (UTC)
Date: Wed, 16 Jul 2025 08:54:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Breno Leitao <leitao@debian.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea
 Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
 <vschneid@redhat.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, jake@hillion.co.uk
Subject: Re: [PATCH] sched/ext: Suppress warning in __this_cpu_write() by
 disabling preemption
Message-ID: <20250716085447.06feeb86@gandalf.local.home>
In-Reply-To: <20250716-scx_warning-v1-1-0e814f78eb8c@debian.org>
References: <20250716-scx_warning-v1-1-0e814f78eb8c@debian.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EAD222002C
X-Stat-Signature: afn5nuhziiy6sbhpr349xn4d5u6kfx4j
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX188QncSd6KETI4SzQbvHnl99aSvwULRtAI=
X-HE-Tag: 1752670468-570265
X-HE-Meta: U2FsdGVkX1/rtGLPXr4VR193lnhwg21mVpNnc3ORz/3h9h0lCQcApRbIya1y2WRzVPRPPUCAaKtL4JYzHTSQ3YvKbBWwKRGzSIW4lNzQWlmuHcYsX5Tp/lhv7vJY651eVg2U5gu7nVTY2y+56AdIFWnsRxyClTwpO1yoz4p2kPYT0Rp1jevYJO5NB+2qe6Uc9hmm3IRjns5a2QxpX2xC/lAUGggc3oIDO6Bmvvua4dmECZLx9hPqO4YwR1uKv8tngcjJbp2kGLvYXccGe+s3o5ofF2cSJNKr0eIBfwcQqFqKZsnEYk8YiBNne9RJIDCHoHqF5ji9HHcZGdXaiACUq/YOh/R+54YSEoPmxOT/YwLTRYiFZJpXsg==

On Wed, 16 Jul 2025 05:46:15 -0700
Breno Leitao <leitao@debian.org> wrote:

> __this_cpu_write() emits a warning if used with preemption enabled.
> 
> Function update_locked_rq() might be called with preemption enabled,
> which causes the following warning:
> 
> 	BUG: using __this_cpu_write() in preemptible [00000000] code: scx_layered_6-9/68770
> 
> Disable preemption around the __this_cpu_write() call in
> update_locked_rq() to suppress the warning, without affecting behavior.
> 
> If preemption triggers a  jump to another CPU during the callback it's
> fine, since we would track the rq state on the other CPU with its own
> local variable.
> 
> Suggested-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: 18853ba782bef ("sched_ext: Track currently locked rq")
> Acked-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index b498d867ba210..24fcbd7331f73 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1258,7 +1258,14 @@ static inline void update_locked_rq(struct rq *rq)
>  	 */
>  	if (rq)
>  		lockdep_assert_rq_held(rq);

<blink>

If an rq lock is expected to be held, there had better be no preemption
enabled. How is this OK?

-- Steve


> +	/*
> +	 * __this_cpu_write() emits a warning when used with preemption enabled.
> +	 * While there's no functional issue if the callback runs on another
> +	 * CPU, we disable preemption here solely to suppress that warning.
> +	 */
> +	preempt_disable();
>  	__this_cpu_write(locked_rq, rq);
> +	preempt_enable();
>  }
>  
>  /*
> 
> ---
> base-commit: 155a3c003e555a7300d156a5252c004c392ec6b0
> change-id: 20250716-scx_warning-5143cf17f806
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>

