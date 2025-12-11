Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08074314D0B;
	Thu, 11 Dec 2025 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765469825; cv=none; b=K62/IYss7kTWlHkWkg4S3l06OZr/js262WUrxz6YEWycY01j+P98sxF4N23RQrtwwZYe2hmU/l/fvvOSuQBGk/fSMyhUI3knhPYT0KdRYIU6Z/QNWLg+QcHBd+ud6vSudmODT9B8D7oV2qgv7iPimxyK+gVxbtpW50QlE4rMfk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765469825; c=relaxed/simple;
	bh=c1C53MWAnXFFzI1YWPUZggnksyhReDP+myCoYC8ekV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pM0GLVhsJO4MOqN/5eq64RgGe3455iERppGV2RckshhRP5e0u8bDjzsN/ZjZ2P3cnOCXHM2u6uMYyFcvV6MCbo3dkLHSq5OvyWkW3CFGJV/e+rg4QK59cr0UHEcwI4l1qJ8nrmK6WLIXFGVJlOj6ZXU6UE3/CiIR79YSVe6gXSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2siaIkB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2siaIkB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77038C4CEF7;
	Thu, 11 Dec 2025 16:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765469824;
	bh=c1C53MWAnXFFzI1YWPUZggnksyhReDP+myCoYC8ekV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j2siaIkBaDxT0fMqEjZ8YqV9ldaxytsVxU1KYLuRpd0pArOIAADaO42YGMZM7Zbmg
	 3UgO/hzeQjnCmyJYzDcAOW3Ry5jIsWS0Dj4j6IXw6eGTQfSjDXbhoYRufPATz6f9X7
	 PSmA2fPQ7dLJzdYKMU37xGLoqkqcfnh2gTBvOvcXS6+j3oJGm3HOfjN/wnKFvd/+EF
	 nhVdTaX28Fukk1IsOnWp7e5IqG7FkhHW3M//TlltlcmT9i3CXOJKwkLgJ5/sV6Log4
	 pN67Qwlus4azYncAAozSuBwdnYoUjPAtgsnvjXB+zsKBmE6043Wa9J6OSK1piW9l+5
	 3YlD6l7p8g6SQ==
Date: Thu, 11 Dec 2025 06:17:03 -1000
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Wen-Fang Liu <liuwenfang@honor.com>
Subject: Re: [PATCH v3 3/3] sched_ext: Allow scx_bpf_reenqueue_local() to be
 called from anywhere
Message-ID: <aTruf0rK94ujYH0f@slm.duckdns.org>
References: <20251025001849.1915635-1-tj@kernel.org>
 <aP-3vOtH9Dyg_R9w@slm.duckdns.org>
 <7e9b27d70e31c243da3ce77e622b0af5@kernel.org>
 <DEVGF29ONM1A.CCTFEV5OZI9D@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DEVGF29ONM1A.CCTFEV5OZI9D@google.com>

Hello, Kuba.

On Thu, Dec 11, 2025 at 02:24:04PM +0000, Kuba Piecuch wrote:
> Since we're doing a direct dispatch, the user scheduler task will be
> inserted into the dispatch queue in enable_task_scx(), without dropping the rq
> lock between example_enqueue() and the insertion, which means reenq_local()
> will run afterwards (since it's deferred using irq_work), removing all tasks
> from the DSQ, including the userspace scheduler.
> 
> A similar problem arises even if we don't do direct dispatch and drop the rq
> lock after example_enqueue(): since dispatching and reenq_local() are deferred
> using different irq_work entries, and irq_work_run() processes entries from
> newest to oldest, dispatching will be handled before reenq_local(), yielding
> the same result.

Oh yeah, the asynchronity can become pretty confusing.

> The user may be unaware of this behavior (it's not mentioned anywhere) and
> expect the reenqueue to happen before dispatching the new task.
> 
> I think at the very least we should make users aware of this in the comment
> for scx_bpf_reenqueue_local___v2().

Documentation is always helpful but I wonder whether this can be improved by
the reenqueue function capturing the dsq seq number and re-enqueueing only
the ones that were enqueued before the reenqueue was called.

Thanks.

-- 
tejun
