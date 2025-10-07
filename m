Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F005323370F
	for <sched-ext@lists.linux.dev>; Tue,  7 Oct 2025 19:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759864507; cv=none; b=hnl8odeuvilo2nEAttnhelxxHkzoo2vC4drlA6KYh1+SsFtB9wp9SXS++hwdc7ow/lyKZ8Cj3M6kRTNWFqx0erywVVRcdblU+FqC2U4x+ngSNQnIAXtrjb/BIe8RV369mxex7qQN/zjbN5VJrlgQmjhxOOm771P/GVF+zEQte1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759864507; c=relaxed/simple;
	bh=VyyF5rzqOmescBTk14qOJ1qFTsw19uhHghX2+3rxGE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3dZdi1hGSy/4FqbI1m+FG2egIB9c7iMFFuAsUjeaCJTzkwl6zsRVX2WAQmfg9AVR/K6Tp9ogVeg2DCIlW3Xvl7+OCBUKmGOHTDNVHBm/dxHxN7C5KZRW3VssClYG8RpfJhP8k0MsmvpjDrepr0lJk8vXNgqHlmmGSm0+ApgcbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQVIB23P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQVIB23P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D80C4CEFF;
	Tue,  7 Oct 2025 19:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759864506;
	bh=VyyF5rzqOmescBTk14qOJ1qFTsw19uhHghX2+3rxGE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vQVIB23PtcUg4OjEZxJjb9l9KG60X2z40QIWJm1C4uFAbpe8F/h9JOoitnH1aDndq
	 jd5bMLka/1G823eXTnWDaMXN5j2ctiJ0zIjTm8rysgXa6XKzaPk2NTOXiQuXy9R1HG
	 g9UMPoZEg2qjG3S/aM2RbTYi1KAuKY50U3tfGFB4Dnvac/oDtU96Ok4ugWc+vlF43f
	 2DmfV0LswhtmEYQT7shLCS5JwMx9IKATWrA+jvkLUAC5eySZWwWCy60KMP1DSNNgtK
	 uieSuMqP2uci2ZjUdV1tTj5VDXIoCFb3O498L1CEua4IZ1rsSaMc9wXGfnwu6UCksG
	 /iaY/OmpIm0GQ==
Date: Tue, 7 Oct 2025 09:15:05 -1000
From: Tejun Heo <tj@kernel.org>
To: zhidao su <soolaugust@gmail.com>
Cc: sched-ext@lists.linux.dev, zhidao su <suzhidao@xiaomi.com>
Subject: Re: [PATCH] sched/ext: Implement cgroup_set_idle() callback
Message-ID: <aOVmuWwyLUNkPG7S@slm.duckdns.org>
References: <20250930061045.743507-1-soolaugust@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930061045.743507-1-soolaugust@gmail.com>

Hello,

On Tue, Sep 30, 2025 at 02:10:45PM +0800, zhidao su wrote:
> From: zhidao su <suzhidao@xiaomi.com>
> 
> Implement the missing cgroup_set_idle() callback that was marked as a
> TODO. This allows BPF schedulers to be notified when a cgroup's idle
> state changes, enabling them to adjust their scheduling behavior
> accordingly.
> 
> The implementation follows the same pattern as other cgroup callbacks
> like cgroup_set_weight() and cgroup_set_bandwidth(). It checks if the
> BPF scheduler has implemented the callback and invokes it with the
> appropriate parameters.

Can you please add tg->scx.idle which tracks the current state?

Thanks.

-- 
tejun
