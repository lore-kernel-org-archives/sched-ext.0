Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F8E3C3F66;
	Thu, 16 Jul 2026 21:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784237916; cv=none; b=ZfpixUA8yuGzeaOJuc244jf46jIKc+UjRJ3l/XcI/CticOzbE+PrebiWejTdUOcoXw5cRojikkCN8hMc8oyWCQ1KQ4dgpAVmAUGA/MA2ouRHhWmJWhyWyXMtTk5+BgHlUoaQY4TZL6bFLUkhnRO4dTkcHE5x4LxSh0VlGGC6xDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784237916; c=relaxed/simple;
	bh=iQ/1AIigDhh2XHJh51jJW0pGfXx+HwezDj2ICxQt8fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HacacojjWXdCqDBIkkalrJ2WAwZtCV9PsdbVh4riPEnuh4VLFR+nHBzQsmfyh9Je4YdSdya1sH1KqnbbfMb1lYmjXZvOPuPsxwg71C3wlkIYsEA7ITmDY1XN+HlYCyHd/F1TlP4zy5b6eYiTe1oKEdZ7ln0ubdj7y80rjXiKFDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwO0PM+c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwO0PM+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CC01F000E9;
	Thu, 16 Jul 2026 21:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784237915;
	bh=newQ5YJA9KejTf5Q7CoKTHz6ZbwhBw2RW+LshDr4KXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YwO0PM+cNBw/526Q+YSSmhoyaUk9R13wEO8ICqVoHyDv8ohfIBK75GchwDpYzJ5O+
	 Bzd/cVc1cDL/EFjooMFUpzm41yg1J4eCEbgWcuUd9hbw1MqRkU2z7cm3Gz3kQDq3s3
	 TaEzy6zJc1TOzF5kSupcRhdFJRE7A2gh3dYzdOHnF/LHpRRhIImY57WRuDPSDUapxe
	 ykIHsmf36jhzSi85l5GP8mlGD50pkcOeeYAENiItzis9ue04q4bxJINC36mJT1DNja
	 Rr4ADQcZ6YZz5l8QK/8mxm7EFidBXAK0YhvY7o89WE7FAaZN63TLG5AVNrWu5+5udG
	 Hl14eLNhAqh/w==
Date: Thu, 16 Jul 2026 11:38:34 -1000
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
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] sched_ext: Fix TOCTOU race in consume_remote_task()
Message-ID: <allPWrXTK-_gbW8k@slm.duckdns.org>
References: <20260716132229.61603-1-arighi@nvidia.com>
 <20260716132229.61603-6-arighi@nvidia.com>
 <allNQY8BZ7qMQjmm@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <allNQY8BZ7qMQjmm@slm.duckdns.org>

On Thu, Jul 16, 2026 at 11:29:37AM -1000, Tejun Heo wrote:
> If this no longer holds w/ proxy execution, adding further conditions are
> fine but let's make it explicitly for and confined to proxy execution
> enabled cases. The logic there is already subtle and I want to avoid adding
> misleading checks.

Thought a bit more about it and the only thing that can change are the
running state and migration disabled, right? So, maybe just test those again
after the lock switch?

Thanks.

-- 
tejun
