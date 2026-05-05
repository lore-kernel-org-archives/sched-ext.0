Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18272EDD6B;
	Tue,  5 May 2026 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777969889; cv=none; b=j+xrEnydZb2irL/nKSv4kszkCqXSXhAGqfVh0gWRAr0M+O4p+nlrcsDiTQc4krUu6BuzROiW8aLIvU5hg270t3l37jwJJ7AagpIRncmiAdgshDs7vSWsG7geFNed1ao3SLYbpAdxU516MjFYBhpOSVQBMDZ1cEZyZ2U9HZj/M2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777969889; c=relaxed/simple;
	bh=UgQkuBXO60MJ0km0jrl0xWSmaJ98fxXc4i7XCGG3ino=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAlH8oD73VwhHAPZ8aBRApL7Uh3SNV8F9xcUWhL82EAeozk5V95PVC6g+f4fHU3Y2BbuSHN4Bh1HmNYqmin2lnLBMZNNHXF1glQ8D2gvsm87OSErlQnuN5f3zucoMzYtJdDy4EpJGdY3aQP4dcnukA3yONJWDBadv174YRli1ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urgYuI0N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urgYuI0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3006FC2BCB4;
	Tue,  5 May 2026 08:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777969889;
	bh=UgQkuBXO60MJ0km0jrl0xWSmaJ98fxXc4i7XCGG3ino=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=urgYuI0N166O1KYBugCgNu8k4a7m1l33bKp0E4y6t5GPQLLPisSyaTzSrwyL7eqU4
	 pNLaNwoKF7CZBlj99VAt+PKfWQo6CbGFyfA1w/b8z9T5H5E7DG71EBaZMEXEtExSmu
	 +uneEqY+agAh5NFbNMDzLXePTY5m7XR4HWvknPYFj/KwpWO8zJ8Oit2LpgB9NXpn4A
	 6p+hFQmlRP//W1O4p+oVj3sFuVvHPHzQAtUxBhrvp9L+8zXUubrxG3UfBOtHjOoBpt
	 nnHiSDc1m2W/q96Z7RAH3KItml9AwBjcQrOPLYsswM1iiSB+GZV7JR+Shr6e10Ovwb
	 /rKAmGzDH5gtw==
Date: Mon, 4 May 2026 22:31:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Invalidate dispatch
 decisions on CPU affinity changes
Message-ID: <afmq4DtGZcf4Zh5D@slm.duckdns.org>
References: <DH7HWWN0HZQM.1ZSKEH89LMOKQ@google.com>
 <acHJED4iAeytdC2l@slm.duckdns.org>
 <20260422142633.G7180@cchengyang.duckdns.org>
 <DI0KLDKWJBOI.2LVQ249QGVJI8@google.com>
 <20260426093756.Gd781@cchengyang.duckdns.org>
 <DI3TFV6PNXZ7.3OR8GY5SBIEZ7@google.com>
 <20260502000039.Ga94c@cchengyang.duckdns.org>
 <DI9QFXIX3Z0R.23PU1FB6DEMPS@google.com>
 <afkOqQRB1YqSlL4x@slm.duckdns.org>
 <DIAL292DWST9.1UIAWWSHW1UMB@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIAL292DWST9.1UIAWWSHW1UMB@google.com>

Hello, Kuba.

On Tue, May 05, 2026 at 08:01:58AM +0000, Kuba Piecuch wrote:
> Could you elaborate a bit on what you mean by "properly synchronized" here?

If ops.dequeue() synchronizes with the dispatch path so that the task being
dequeued is either dequeued or dispatched, there's nothing else to protect.
If ops.dequeue() wins, the task won't be dispatched. If ops.dequeue() loses,
the task should already be in either the dispatch buffer or local DSQ and
the kernel dequeue code will shoot them down. In the former case, at the
dispatch buffer flush time, the task would either be already dequeued or
re-enqueued with a different qseq and ignored. In the latter,
dispatch_dequeue() would remove it from the local DSQ.

> To me, introducing cookies is primarily about adding flexibility around
> managing the "dispatch window" between the qseq being probed and the actual
> dispatch attempt in finish_dispatch(). For example, a CPU can get a cookie and
> pass it to another CPU to perform the dispatch, which is not possible with
> the current interface.

So, this is mostly for schedulers that don't want to or for some reason
can't implement proper synchronization between dequeue and dispatch paths. A
convenient thing to make life a bit easier.

> On another, slightly related note: I'm considering making scx_bpf_dsq_insert()
> and other dispatch-related kfuncs that manipulate only CPU-local state
> callable while holding BPF spinlocks. This is something that the comment above
> scx_bpf_dsq_insert() explicitly mentions:
> 
>   This function doesn't have any locking restrictions and may be called under
>   BPF locks (in the future when BPF introduces more flexible locking).
> 
> I'm not sure what "more flexible locking" means here, but this can be
> accomplished by simply adding the kfuncs to the list of kfuncs callable under
> spinlocks in the BPF verifier.
> 
> Are you aware of any previous work on this? Any pushback from BPF folks?

That comment was written before bpf_spinlock was introduced. Please feel
free to allow thoes functions under bpf spinlocks. BTW, there's also arena
spinlock that is implemented in BPF proper, which is already used by
multiple schedulers and likely to be the default option in the future:

  https://github.com/sched-ext/scx/blob/main/scheds/include/bpf_arena_spin_lock.h

Thanks.

-- 
tejun
