Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62A72FE59A;
	Tue,  2 Dec 2025 23:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716731; cv=none; b=r/a8QeEItD6/v/jCU4uUDTdUxe0WlYL8+M/1ZxtpIbnlUl9JmlVfYk2PP2Is/fq3LvQeJmKFNJTrFjGta8rH7s85loXhH49fjqO+FRESyVEuhUKX1SLsg87hZAKv1c0r8/rzDBWnI6c5bxtIOQHqd/dRNEu98gPw4gm6LCTW92g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716731; c=relaxed/simple;
	bh=V/68WdcGNOYNO8MKWEDUKwaJPiHQ4nJ6zxCMle/DbKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q45r9Ijz7WZ533i2qr1hqAqE7TWtU7xp3DsVWUgpM+MgD5aAMrL4qOEqlnSRRcEKe57JbbCqG+EsA4LQY83qYoVZH8AGTqMTgsmka09KfJl7YN18D+I7U8Cc3jkQXYG79LgoyaFtP2wpRxELG4J7ZcS1m9tJWxQO35+iXfy6zQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foQuj+U9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foQuj+U9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041CCC4CEF1;
	Tue,  2 Dec 2025 23:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764716731;
	bh=V/68WdcGNOYNO8MKWEDUKwaJPiHQ4nJ6zxCMle/DbKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=foQuj+U90J5LRTSWJ7waXdHShHdxCUIMZeq234neu79CokhkwMY33ySXw87ndXez0
	 yTrIUoPHZhfdypfbU9zG4Rm3W/ZhJX+H9+XcQ0jKmYUQ4beD1NWKz98dL9qKSLvPuY
	 eVwEoolR9z1vsMSAzUeRJNyTTHwG9KfdnMXLxXSZazUjSOJlLEGvHSRryiUgZWegb9
	 bkaG5KKAmex6NHWiGibkYcKfwl6ujdXCuaYIJ5K6wrnFn82zvCEGNswq9pUNQsgdjL
	 idywDFrUYk48MOd6Y/Z9GSrnaO8VF5TYTTkvkRsI0LQgh9g9VqZqoZ8qhOimPe7H7V
	 Vq9rcNpbR3Ciw==
Date: Tue, 2 Dec 2025 13:05:29 -1000
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Wen-Fang Liu <liuwenfang@honor.com>
Subject: Re: [PATCH v3 3/3] sched_ext: Allow scx_bpf_reenqueue_local() to be
 called from anywhere
Message-ID: <aS9wuY2zu78rSc3G@slm.duckdns.org>
References: <20251025001849.1915635-1-tj@kernel.org>
 <aP-3vOtH9Dyg_R9w@slm.duckdns.org>
 <7e9b27d70e31c243da3ce77e622b0af5@kernel.org>
 <DEJEVK0YKMWY.116BVU5P5G91L@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DEJEVK0YKMWY.116BVU5P5G91L@google.com>

Hello,

Sorry about the late response.

On Thu, Nov 27, 2025 at 10:39:35AM +0000, Kuba Piecuch wrote:
> On Wed Oct 29, 2025 at 3:49 PM UTC, Tejun Heo wrote:
> > Schedulers can now use standard BPF mechanisms like the sched_switch tracepoint
> > to detect and handle CPU preemption.
> 
> Correct me if I'm wrong, but I think using the sched_switch tracepoint still
> leaves us with no preemption notification in the following scenario:
> 
> 1. An RT task is running on the CPU and blocks.
> 
> 2. pick_task_scx() briefly drops the rq lock in balance_one() and the RT task
>    is woken up.
> 
> 3. SCX sees the enqueue and returns RETRY_TASK from pick_task_scx().
> 
> 4. The RT task is picked.
> 
> 5. Since prev == next, we don't enter the is_switch branch in __schedule()
>    and the sched_switch tracepoint isn't reached.

You're right.

> The BPF scheduler could hook into trace_sched_exit_tp() to work around this,
> but that tracepoint seems to be for testing and debugging purposes only.

Yes, that looks useable for now. Maybe we can add another hooking pointer
after the proposed core change from sched_ext side. Will think more about
that.

Thanks.

-- 
tejun
