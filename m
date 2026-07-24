Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D6A38E8DC;
	Fri, 24 Jul 2026 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920060; cv=none; b=QXPnehaHmTAT6/SpDqc0rq0ZYtIat+ESL2NiQeiQ2XfmA3Jlvru9LA7eBCe30t2LhuhzYD3sBOi/BvMvZc313v58aECtobVCJPIpwXY7bJcYFSM7d63Piv1/80eeO3NaTRlETaCLJhVN9IiHGLYGwf7QHRFeyj68/SB2P2YJg5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920060; c=relaxed/simple;
	bh=4Tw3YgbfDU7E9pgKiey4QWvo6mORyFRAsGyPC5gOfUs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=qMi7t87bOVXXjeqEEWLmwNoBd+Cdf83PxwSvgJ4hLFCQTFxRgphlBXnfH27RGGTw7J7xY0lq8dsM6ak69CqIsAu4/Ij/cAwvW0ycEGh1eXpdM28jatwR9i2/WoGzP5989Cw48HSH7p/Z+Pwz2oHpGZpZ8DNr1QJBtWy58WBLeaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oI4V28F3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oI4V28F3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D0F1F000E9;
	Fri, 24 Jul 2026 19:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784920059;
	bh=4Tw3YgbfDU7E9pgKiey4QWvo6mORyFRAsGyPC5gOfUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oI4V28F34iUOLhz6Qpjh0AlFifTFRJMr8yr6EebXthbnU/hElOkj70u3Zjvg6/Ubc
	 CFyU2wq1gyDx9tMOaDtJvjG7r4pMZw8h6PdkNfBiMh3yHhSNfxNjAXPcFE8F9pJQF9
	 kno2ZWF01NdcPm884HnhwIFmfMxw7Cw9h2VjEnacWsSD0K7tW0XRfepWXVEq0S8JUU
	 Z8qng2HmtsH09NTKGds7hYjmn4ZBklc5pQCC+nM+i3MAzl6pvRtUIIx00WMDEbi48B
	 xsfVQFMUwfh6Uvqf+8snbpirH9MPhyAyJkHa2LKCngk6iH+wgPNVeJ+DkkPo3EAlmC
	 e1FVHeWtVlmTw==
Date: Fri, 24 Jul 2026 09:07:38 -1000
Message-ID: <6a08803ec5039a76e591a847ba218abe@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH 4/5] sched_ext: Factor out scx_cpuperf_set()
In-Reply-To: <20260724183056.C9DC41F000E9@smtp.kernel.org>
References: <20260724182125.985061-5-tj@kernel.org> <20260724183056.C9DC41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Fri, Jul 24, 2026 at 06:30:56PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Low]
> Does this disconnect the kernel-doc comment from its intended function?
>
> By placing the new static helper scx_cpuperf_set() directly under the
> kernel-doc block for scx_bpf_cpuperf_set(), kernel-doc will parse this as
> the documentation for the helper instead of the kfunc.

Indeed, the factoring left the kernel-doc comment attached to the
helper. Will move it to the kfunc when applying.

Thanks.

--
tejun
