Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7DE328637;
	Fri, 28 Nov 2025 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764337475; cv=none; b=TF4mG/kDExYDOohh9Am82hUE5yiDExp6GGEp6Y+oS4I+m/ciHYoXKcpBmy0rzfvIs7eg9bfGyffQ5TUQhklGQTaQt/UxBR3LSPivHUJWZaaubHsijGJyG4CQN2JJpKrfxupwxugiAmdCKOCtebcFl/CS62m8CcxdBXk/ZO7A+qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764337475; c=relaxed/simple;
	bh=O306X0Xg0ogWa/RgLH0BB/ZxhxjkSSBiLvYp4fRQ7yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsbSV5WnfhLaddt6+oi1O/HjCIHpYrM/J3UYtnLp+zlSwwUsiFK95x80rBhOyfq0ldQEfCZBPgoVXRZ5kXhw811VLTUxNy2D3ZUb9FEhVV7yTjk/jkcHwUA0xgSqlHbIXmOlkkxTiA0XtLTd5GHX1L8nvHA4vOPxinGTcPlorCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LgmGGbTv; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LgmGGbTv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HBhGlWi6/BrnCTF/yl2XTmSLoLZRegoD7Izmm6bd89A=; b=LgmGGbTvYrM2dm8sP8lSIoBpk1
	X3lL2CmmIt02Ov8th1Cj478nQL0IxbmDI4/iDST8Sak8ROvV/fkmKPBE59NRKupF6Imw5eYs+Usuw
	QThI4k7Ng4lqcgroKlcc9OJIx6D1sVYUmA6AnhFmvlCCKs0ZBpmRT51OXVY6ulefebkjyXlau4R6T
	GVbxpRNbZQR9YQaQk+Zp8Y83Vldl7jKaxtLEZ0RLAca2yflHDjnz7eIb9PcCSwFXYnPyGpyumWbRS
	788wiq9yiTB5/umbujOcfzHKw73Fb3KEfU5BT3Q8dmexPUQBZYGtYlia0nmsvLhdz1ALgQ6wdy+cE
	7nSEQVzA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOxuN-0000000BzKh-00D9;
	Fri, 28 Nov 2025 12:49:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C18A13002E3; Fri, 28 Nov 2025 14:44:27 +0100 (CET)
Date: Fri, 28 Nov 2025 14:44:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: mingo@kernel.org, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH 5/5] sched: Rework sched_class::wakeup_preempt() and
 rq_modified_*()
Message-ID: <20251128134427.GS4068168@noisy.programming.kicks-ass.net>
References: <20251127153943.696191429@infradead.org>
 <20251127154725.901391274@infradead.org>
 <DEKD1W6CI6UJ.3TWR30PXQCF8O@google.com>
 <20251128133638.GA4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128133638.GA4067720@noisy.programming.kicks-ass.net>

On Fri, Nov 28, 2025 at 02:36:38PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 28, 2025 at 01:26:30PM +0000, Kuba Piecuch wrote:
> > Hi Peter,
> > 
> > On Thu Nov 27, 2025 at 3:39 PM UTC, Peter Zijlstra wrote:
> > > Additionally have set_next_task() re-set the value to the current class.
> > 
> > I don't see this part reflected in the patch. Is something missing?
> 
> Hmm, that does appear to have gone walk-about :/

Aah, here:

@@ -6797,6 +6799,7 @@ static void __sched notrace __schedule(i
 pick_again:
        next = pick_next_task(rq, rq->donor, &rf);
        rq_set_donor(rq, next);
+       rq->next_class = next->sched_class;
        if (unlikely(task_is_blocked(next))) {
                next = find_proxy_task(rq, next, &rf);
                if (!next)

Will fix changelog. Had to do the above instead of set_next_task()
because if proxy stuff.
