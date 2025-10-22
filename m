Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815CA2FB0A6;
	Wed, 22 Oct 2025 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164877; cv=none; b=Dloqag8x/2gdsD38hH+H0ZuIr42mxw/TrcHfuL9mUoctnlF975m3xOxg5psNIYsABC75/78UyjIQ+qDZfKJReyeovULrEAWbFF2ZZftQ2o76wxrQUH/hO/Rva7NPQITqgOu8t/lTDHD3Al25ruUMEkuNmt60M0GkbqNcbckG+7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164877; c=relaxed/simple;
	bh=tVBEed3VAVgVl2VHnxu6EsWdt4x/Yjp9/jd2zsHBqFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPa+ICvJBdyjKs9H7fx0bOR6CHAcYrBMqid47uM6lMJ6VFhHdvDtD3iRTyeveQ8TJt5ckeaE96FqsF0rAZ2MJbxKp5x4DALKAnsHw7yfOENiAYSVsjM1XvBjnh0fygsWO1bafybe7wZ9QrHZ5kksi2hSOUU2DFAI37OOzX4BdKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIthv+VO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIthv+VO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76E8C4CEE7;
	Wed, 22 Oct 2025 20:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761164877;
	bh=tVBEed3VAVgVl2VHnxu6EsWdt4x/Yjp9/jd2zsHBqFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pIthv+VObm6D7MYUOIQdB0uTf7cb2HFUVDiqbiOY1aKALjN1PRjvisVqQbvv5PAQJ
	 kmASrUdXYDYNqk45JNOPlq4s9HkIWBMT+ZuBitEeirbWj1FKfkYlm1wL8MDWSn2vg8
	 oPLFPfMQmMFXDDQUS0z3KirqzzFZ6joXmYqu94Rf890iTJPijxPhtigwy7Dzdze68h
	 /yCkCV6q4/NekJWZ5TWMf/PvHwM5UhOA2aVOZhY2mAYLhnOfQSt9rVgfg9qYAIQJAb
	 NT2tY2UkZfP2DpSo4ymSkcTNLKK+jmEqYLxKwGg/cr/MaQVcmfozxbjR/qHIUl4s/5
	 eZm54dDpnOF+w==
Date: Wed, 22 Oct 2025 10:27:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-6.19] sched_ext: Use ___v2 suffix for
 new kfuncs and fix scx build errors
Message-ID: <aPk-S_E82BD1YfSM@slm.duckdns.org>
References: <20251022093826.113508-1-arighi@nvidia.com>
 <20251022153610.20111-1-arighi@nvidia.com>
 <aPkHqpPGZ-9EBGUz@slm.duckdns.org>
 <aPkyphtSDYDydnUm@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPkyphtSDYDydnUm@gpd4>

Hello,

On Wed, Oct 22, 2025 at 09:38:14PM +0200, Andrea Righi wrote:
...
> Ahh ok, so user-space schedulers will always continue to pass all the
> arguments "normally" and we just assemble the args struct via an inline
> helper.
> 
> So, IIUC, using an _argpack suffix or something similar (instead of ___v2)
> should be a reasonable solution, right?

Yeah, something with less than three underscores as that has a different
meaning (ignore when matching).

> > Here, there is no noticeable feature difference before and after for
> > existing schedulers, so I don't think it's necessary to introduce __COMPAT
> > prefix.
> 
> The problem is that some schedulers (i.e., scx_bpfland, scx_cosmos) are
> explicitly checking bpf_ksym_exists(scx_bpf_select_cpu_and). If
> scx_bpf_select_cpu_and() becomes a static inline, we break the build and we
> also break binary compatibility. Hence the __COMPAT for the inline
> helpers...

Hmm... binary compatibility shouldn't break as the original
scx_bpf_select_cpu_and() is still there, right? Build breaks because now the
symbol is an inline one, but the solution there, I think, is either
providing a __COMPAT macro which helps testing the availability of
scx_bpf_select_cpu_and() or just making them test the ___compat symbol,
right? ie. kernel API changes aren't required to guarantee source level
backward compatibility (like how we did the dsq_insert renames) as long as
it provides a way to maintain both forward and backward binary
compatibility.

Thanks.

-- 
tejun
