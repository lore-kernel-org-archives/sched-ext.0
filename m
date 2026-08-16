Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8414530F932;
	Sun, 16 Aug 2026 20:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786911645; cv=none; b=p0jhs5MiVFGkTz/IP/QmZK5Eti9aQSbGXm4HwN6GgbNhkv5PrxCg6xUwgNeodjiKT4i9pBQybSDyWpE3HH/8c8VdmT1S4G0wfWVRdlHNqSUeJlLmdIotRktlvGpeQl+V2qY+QOa4XFjr9wrdra3xOFRpjG7I+gatYi0lssS3fVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786911645; c=relaxed/simple;
	bh=aOeG2bVxlcAY6bpGisFEmPHRhGs4WFUQOQCi0bBJCP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYcTG0bV5FgjdbZ1G3rklvoNdzQ1199dkVW0efa+p9V2fKFCQ0XvTkM+/mc1jOxztburDCnFuOwajWW5cnjqIUiQwEXWGlXPuUPNYCr2eZpqRN0W/HGL0ZsPXhnPEnq+cKrLQxgMhOkMxXRy+fzycKHEamu0UV23HicaDIKpXZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgov1la6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgov1la6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E869F1F000E9;
	Sun, 16 Aug 2026 20:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786911644;
	bh=CMB0N4KsPbiP6W2b8O949UKQkmzEWfpHURyVZr+IgmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hgov1la6dzSQAZLqT1GGSZUvB/LliBIKyZdh6rMPpkWRHabLEGS0J1p1P8R8XCmTc
	 ZWOe6GbOZrWxkjIcwQZhlJDxGh8G9+26DDB0ipTcQpHOs0PltekpZoaLB9d+MKSJWA
	 uyxdN6iRncoQZuOnjhoBhX71nYWxQbDlrz/Ll6ukcxA4baH+f+If1Lhasjj82ADUGi
	 zuThsX+Qp158aseEuWhmcBuTFpwOPNFEeeTlZlQgQ5WYT+sZsEeoGAgxXuXXgSTu4A
	 OmtGNFh1j0n7gEn+ak6u3d7VCGbOLPY6vCCH/xKdwtu2dPULiIi5cbEiv70aQPUTVz
	 1uTgl4Yt1RZnQ==
Date: Sun, 16 Aug 2026 10:20:43 -1000
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
Subject: Re: [PATCH 02/17] sched/core: Dequeue waking proxy donors before
 reset
Message-ID: <aoIbm1-oACB6AZG6@slm.duckdns.org>
References: <20260816173732.17162-1-arighi@nvidia.com>
 <20260816173732.17162-3-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816173732.17162-3-arighi@nvidia.com>

On Sun, Aug 16, 2026 at 07:35:00PM +0200, Andrea Righi wrote:
> +	if (reset_donor) {
> +		bool dequeued = dequeue_block_task(rq, p, TASK_WAKING);
> +
> +		/* Keep on_rq set until all donor references have been replaced. */
> +		proxy_reset_donor(rq);
> +		if (dequeued)
> +			__block_task(rq, p);
> +	} else {
> +		block_task(rq, p, TASK_WAKING);

nitpick, would the following be easier to follow?

        bool dequeued = dequeue_block_task(rq, p, TASK_WAKING);

	/* Keep on_rq set until all donor references have been replaced. */
	if (reset_donor)
        	proxy_reset_donor(rq);

        if (dequeued)
                __block_task(rq, p);


Thanks.

-- 
tejun
