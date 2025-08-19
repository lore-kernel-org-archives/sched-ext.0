Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE2E3101D1;
	Tue, 19 Aug 2025 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755590247; cv=none; b=k8K4VJGgbGvDPU9fOjGJV22s3HXfWZjzJNeWOVaB42cdLicQYKeYB5LOCfL8PPrICnIg9rM7pyPUFAuTlUhPwWsUD0VrBmEcK5W2F+8amgiCRJHXTIsuXRfVZMY9hokpdCrY5CHOW2MTrzv7ZM83+a7Mqp6F2qPabwjUkrWB9LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755590247; c=relaxed/simple;
	bh=6pvltH+FqpRjs3ghx0QZ/sWmg06Mxyz5vKd8SKGqpzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9v3gYdxV0naLsrYbNyr5nAVH0thYORI1sU3cfQwWxPV3AlOPOqLCaUgUyXctFIS54m2dLMG/EDOVsefjP6Ow9+R0fu7WLYNRUP4pP6AhByBpBraa5nNFI1WEWeet/YL2kz9gFC3CLNdJ0ViLnsWzCVVrQe0NgUnRlV1txYey1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EJB2prlL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EJB2prlL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VmIosm4L4PY+P0mM7SGV9Zk2/LL+r6zCjeW39m4X7t4=; b=EJB2prlLkNY84ehu1mS2n4wkjK
	L7qoY/lgnJ0QODp7pnIdbkLBELGIxv6/JEQVcE0fhzPlZI29hzmg2y4+pTZGOWef5U/TCJIotgmbK
	czMGROWYX6rUZlJZwoYIYngvaJzVWc31otqJjkETJjehxgXXVWmbdTsDBg7hobZ2BzJg+YY9qJwal
	dvXMtQJyN5PQL0YOvTqAHJIDXJQdZHzAK4d7sPUfkB/CeqvNfOfVGE/80Z4QRyrdcApSwNkxeoqLp
	YCZz9ZXSk0pG+/Wunlz+NFG/Grc3ZANU0XG52ZNyPqLKEYP1g+OfJeZD6y3cbi4kEOIhvT9qM1Yjj
	TogBDSLw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoHDX-0000000Haj3-42yj;
	Tue, 19 Aug 2025 07:57:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BBDF830036F; Tue, 19 Aug 2025 09:57:14 +0200 (CEST)
Date: Tue, 19 Aug 2025 09:57:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH -rebased 07/15] sched_ext: Add a DL server for sched_ext
 tasks
Message-ID: <20250819075714.GE3245006@noisy.programming.kicks-ass.net>
References: <20250809184800.129831-1-joelagnelf@nvidia.com>
 <20250809184800.129831-8-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809184800.129831-8-joelagnelf@nvidia.com>

On Sat, Aug 09, 2025 at 02:47:52PM -0400, Joel Fernandes wrote:

> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1510,7 +1510,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
>  	 * The fair server (sole dl_server) does not account for real-time
>  	 * workload because it is running fair work.
>  	 */
> -	if (dl_se == &rq->fair_server)
> +	if (dl_se == &rq->fair_server || dl_se == &rq->ext_server)
>  		return;

Does that want to be: if (dl_se->dl_server) ?

>  
