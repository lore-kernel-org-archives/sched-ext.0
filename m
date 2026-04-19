Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BAA29430;
	Sun, 19 Apr 2026 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776626118; cv=none; b=PRyUo75z2krsuYAQB7ma4rFVPyH7VcfmJc4LMQJCHLCwVlKsZlXbqEUrgSpa3oQNtGT6wVixbj3bEcgGFcl7PTLyFfNE3+0OiARmBl7gBiqZigblS3Ag95KgYxR78wlppdhXP7J8cMAjlBJceVyMnb4LsAGhfofBlSUmLIfFlgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776626118; c=relaxed/simple;
	bh=jXDbvKYJMfxC9Iq1IFc0tvFIadBwQf2Mna0oPc1WSHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLN7z2gXEK+2LjxJPgjkSzpt2OI4mQN8Uv23ojTY/OfVrCd6QdqefmdlX7gxlG8h4RPuG+AX2U53XQZe863jnJ2n92rrIyXBq3/plUCZc48cgxJf6jclCzhOH4iVO7kIyw+KwRZnuPpzwPcUfcxU9rXE/5jYuzJmDOfzL6rn+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnVQnF3G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnVQnF3G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BAFC2BCAF;
	Sun, 19 Apr 2026 19:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776626117;
	bh=jXDbvKYJMfxC9Iq1IFc0tvFIadBwQf2Mna0oPc1WSHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fnVQnF3Gzw46Hpe4/gsZSRtSIswO91Qo7fJbC8mJKQfOm4XvdhjYqmk7N1AHBnAQx
	 qcolj+D8rXKY5IsOQgVcSH0UAc0joWlMz8RePKbeUz7qET3KNwboZPDVJMgdxrxcqk
	 2vhg5q2ut25MjbduL0k/Gnw4MB6t9/OOvFAeXTSMzLNaz59i2on/zhbBFnqQECSPoV
	 C7z0Sh0Vg1VrZj6eCE9zChhz1OH1XD+5SCDHln/N1NBwBtSXs2467XeSBK2fpS97Kj
	 fxKHbjLtYrSODSIYTjWPD8cLNMRaaFdA/jW3CG5PU9bDo/KfAfkl1WJzu133BgKDgG
	 be4dkW2UxVJvA==
Date: Sun, 19 Apr 2026 09:15:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v3 sched_ext/for-7.2] sched_ext: add p->scx.tid and
 SCX_OPS_TID_TO_TASK lookup
Message-ID: <aeUpxKBfgvgA1AWO@slm.duckdns.org>
References: <c3069bb592d7d09790ca9ff6d9b7d3b2@kernel.org>
 <aeUms-ccHZhBNVKn@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeUms-ccHZhBNVKn@gpd4>

Hello,

On Sun, Apr 19, 2026 at 09:02:11PM +0200, Andrea Righi wrote:
> Hm... WARN_ON_ONCE() only fires once, it can be hard to catch subsequent errors,
> especially in case of -ENOMEM.
> 
> How about triggering WARN_ON_ONCE(ret == -EEXIST), which should be considered a
> real sched_ext core bug, and use scx_error() for insert failures (ENOMEM).
> In this way the error is more obvious for the BPF scheduler and can immediately
> exit if it happens (even if scx_error() is probably a bit of a semantic stretch
> in this case)?

It can't fail with ENOMEM with insecure_elasticity set. It should never
fail. If it ever triggers, it's a bug that we need to fix.

Thanks.

-- 
tejun
