Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7971D3DC4DA;
	Fri,  8 May 2026 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778254110; cv=none; b=irRWADXruq0smYMUUOFgJ6xSEQTQ0/ziUtY4xTT42gbl230lVGjy6+eHcSRQRk0BGDpRsOHgC5YwIDdWVCr7/CmmM+LwYikODHaM0Y6sWGidhhs1f4hZYaQ9RjOzbtSD7jc/tfp6nEKrvb5Zwh+1DM63sMikG4BVi3jTss+rdeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778254110; c=relaxed/simple;
	bh=jf39R9XWJ4uRgRqxOzgJYLy8D7Gg989RrRg2RJyc6bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPvwdqdtGyO+2BBynewfiQ6/S/aFixWAXQaMQN6HisdxcUw74hJsH0tMsVkFYyqberNamB5oCboNnRfsgcmmTCVcWfmbGVLU+ImEGOjH1+porPDZG4ArCza/U4s6GHhWat5YkjvOW4fL7FSleUXkyyu0mhdjDEgR46edBf0nNBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/iquEsu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/iquEsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01002C2BCB0;
	Fri,  8 May 2026 15:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778254110;
	bh=jf39R9XWJ4uRgRqxOzgJYLy8D7Gg989RrRg2RJyc6bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/iquEsuK2NCoolvYL66zi6+QJyKTXdudyaw6i6e3V0X4RjU0D1rkQlSSSN1lzdzU
	 fm6pkZxvEtFrAstiz4J5z2TxqAoV9dBFb0D/e96P3iha+Jbnl3MgMUhCN7bxr+c6PT
	 6H4ph0nN9dCB7CaIGXCFUOpftgT4Q7zhMDEtpxkPM5UiyPwsFN0uKf4cmd5ACK+ege
	 zh6r1Q4kuZL5trtSqHUywD+IljJwuKb8orQ60qeNKEFuJa4FesxECq5KOZwW/p9gOk
	 Lh4VJMMWYOBZhrUrFSHJsDIXKKo1QWYkoHDaQ4awHmBOKrpKpvHpQabo0RSLFWja9P
	 /iokZcdSt5chg==
Date: Fri, 8 May 2026 05:28:29 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com
Subject: Re: [RFC][PATCH] sched_ext: Allow consuming local tasks when aborting
Message-ID: <af4BHTzRaDx8aZPh@slm.duckdns.org>
References: <20260507135642.692290-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507135642.692290-1-christian.loehle@arm.com>

Hello,

On Thu, May 07, 2026 at 02:56:42PM +0100, Christian Loehle wrote:
> 1. The BPF scheduler's cpu_offline callback calls scx_bpf_exit(),
>    setting sch->aborting and queuing the disable_work on the helper
>    kthread.
> 
> 2. The helper kthread (and other tasks) are stuck on the global or
>    user DSQs because bypass mode hasn't been entered yet.

The helper thread runs RT class, so it doesn't go through SCX at all. Can
you try Andrea's patch?

> RFC:
> I guess this reintroduces the live-lock of a BPF scheduler having a
> highly contended DSQ with a lot of tasks and the outer loop holding
> dsq->lock and therefore it still taking too long for the bypass to
> activate, is there a better way?
> I also couldn't trigger a lockup through that, did I just not have
> the right platform (e.g. 2x Intel 8480c). Should we add a selftest
> for this too, then?

Dual Sapphire Rapids is where the problem was initially observed and I could
also reproduce on dual socket Zen 2 too. SPRs are way more susceptible tho.
I *think* I was running scx_simple with some mixture of saturating
stress-ng. It wasn't that difficult to reproduce. We should probably
document the repro somewhere. I'm not sure selftests is a good place to host
this sort of repros.

Thanks.

-- 
tejun
