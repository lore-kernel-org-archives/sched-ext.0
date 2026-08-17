Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0892E37FF68;
	Mon, 17 Aug 2026 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996198; cv=none; b=q31Aqe/VVZBGA9iKCnTTzNOMrgBaW30KfLmqDQtfBT+yU1m/HJkeTqrkI7U2nCHSZ12h2GIRS9ZiOSt4sr5K7wcmdo5i7jZI6lAbiTzruRJ24r0nIowCBd0XV+802Mz0nMRJk7Z5dUtxPzgkwdL7jcsqZNNLQMRPaaeWET7qZ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996198; c=relaxed/simple;
	bh=UvpokTKR7IhFVtkymN/ZRhqGVJRr7V9VosITiCVZH/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sq2n7AbTWSYyzRB8K25ZReGYyHuL3bOhStg7S2MDO6OjH0GkPdgq5K6Ys1gfbiiHl1XwXJnmCSU3SB3LXrQ+5cDFlPjyb8780VPY8GI7jKNaOxpOj8qs9lilD5oPi0fZd+pKh5vd8ZoTePcnbZHxd1WfLLRwuejRrg0qXlGuXoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2BCgyuf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2BCgyuf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793201F000E9;
	Mon, 17 Aug 2026 19:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786996196;
	bh=QUVn+MctyVpQbBo8u7MtfcQOUCPQMjAamdUag18CzzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D2BCgyufWoXqXUnGU1sbu4/QbHON7ANMjU0jDqduoLGEScPOf9X7CspL25O/W8c5O
	 sh1S/HN9/7ej3fkSqJ9EEgGlHyzCWqW+sjCkKNckm6BtdVSkEwaQigB8Y0zi1+eFaY
	 fp5wYiK6CUa/eM89SgOMp13QLmFTWp9gudLOrorXnayCmPDjJQR+oFHXzUsK3YQaWT
	 3KGclZXpcGd9XCWDsrKatHxA9Y3BOL2U/NvOVr2gkQVnij0XnOCGklWxQGOp/wX9Uh
	 9coPDl2UC5GF6s0BBxBZakJoASou3V3jHSLDZ9ehKb+JXogA84OkPrrGFucQSQoROb
	 oAvE1AIuN1iZw==
Date: Mon, 17 Aug 2026 09:49:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/17] sched_ext: Handle proxy-exec races in remote DSQ
 transfers
Message-ID: <aoNl4ziRiD9QxsOy@slm.duckdns.org>
References: <20260816173732.17162-1-arighi@nvidia.com>
 <20260816173732.17162-13-arighi@nvidia.com>
 <aoJNrhYq_MjO1bDb@slm.duckdns.org>
 <aoK1Ck67oyhysjQD@gpd4>
 <aoNCIwlkVXKNgM5l@slm.duckdns.org>
 <aoNh1gAh1e8zDRKD@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoNh1gAh1e8zDRKD@gpd4>

On Mon, Aug 17, 2026 at 09:32:38PM +0200, Andrea Righi wrote:
> > But wouldn't it be able to use the same schedule_deferred_locked() call like
> > SCX_DSQ_REJECT case so that the PROXY_REENQ flag is only used for retry
> > cases (and maybe renamed accordingly)?
> 
> Yes. The initial insertion into reject_dsq can use schedule_deferred_locked()
> without setting a proxy-specific flag. Then we can set the flag only when
> scx_reenq_reject() actually skips a task because it is still running or
> donating. How about renaming to SCX_RQ_PROXY_RETRY to refelct the new meaning?

Sounds good to me.

> > I think this is a generic problem with core scheduling. SCX assumes that
> > deferred scheduilng always runs but core-sched can zap them. We probably
> > need to address this directly using a similar but generic deferred work
> > pending flag.
> 
> Agreed. This isn't specific to proxy-rejected tasks, any sched_ext deferred work
> queued through a balance callback can be lost if core scheduling zaps the
> callback.
> 
> Maybe we can introduce a new generic sched_ext deferred work pending flag, kept
> set until the deferred work actually runs and we can use it to rearm it after
> callback cancellation?
> 
> Probably something to do for another patch series...

Yeap.

Thanks.

-- 
tejun
