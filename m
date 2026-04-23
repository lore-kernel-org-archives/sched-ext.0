Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DDD3C7E1D;
	Thu, 23 Apr 2026 21:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776981428; cv=none; b=UdyHbaJajPdZ36SkZF/Y+SzXqsnnHllR10NMr/liGRX9vd21Ins9ndB2xEo7w0aM3hLVPrhJ39xJrj9fQg/yv7e3teyBKOkELMiwG8c9rS9DUYLNhXpqYlv3LL0suO/cNzT3UxGoBSJoV6aotYAs5LIX1S9v+pJ/0X7UM8kEkCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776981428; c=relaxed/simple;
	bh=S7LtGkkiP+/x/+M510UbTmRq3BfYlTyXHOFWBKzqGTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLdmruphUq33jBKqmJENzsgqkDjRBEUhjFQcQFQOernWJz+/FQ0FIu0Dz6KFXEUBUHt3ye3K1N8SUjp0YmtZMSbn+WLdNsK9lAgx1KZr8eqtoijH7Dw+Sg5+WxvpQf/4bxjMnQYGs9xS8QHPy4EPYJ4h79dOvYa1T/ZOEq7W7rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tctDx+Vp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tctDx+Vp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B57C2BCAF;
	Thu, 23 Apr 2026 21:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776981427;
	bh=S7LtGkkiP+/x/+M510UbTmRq3BfYlTyXHOFWBKzqGTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tctDx+VpLDj35Ivozejma9Ed/OVM4rA3HWkVRLcBEqiGsDO6jcPZhg1LdNtVJWNFA
	 SdQd2ks5qmZIpEH54zMJqYih8Ck/p3Od0j2wh44znxzE5FdB176iQAqmNLFkOGnYQw
	 35QICw/XUskygWHilq9q9TKIJESA1kW+HsVLm8ygD5ZOC3WtRIjFRqswzjBHnfum3v
	 3yplC1pqWCvwsu60NlA2CUxSuxVNSmi+pi3n0yesqU+pcDYZHzAOFeoC/NHnEgseKb
	 PO40C1+6PDwYPfkhCGlwvj6gTV3eC8QvGZRXRGN4ITTL53HMwEycC2BwjActIVuv/2
	 yJ5Zd5r+M4phQ==
Date: Thu, 23 Apr 2026 11:57:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: SCX_ENQ_IMMED potentially leaving dispatched tasks lingering on
 local DSQs
Message-ID: <aeqVstPcyR_WMCas@slm.duckdns.org>
References: <DHZPHUFXB4N3.2RY28MUEWBNYK@google.com>
 <aej8cmhZVhsqogr4@slm.duckdns.org>
 <DI0FTX13UW17.1IZJ9TMG9EFRA@google.com>
 <ad24a49fd02d7b397976975a13767bb4@kernel.org>
 <DI0RERGK9HKZ.Y3HZ3N7J3RJY@google.com>
 <aepzL1xOEqh73hHo@slm.duckdns.org>
 <DI0SXNWQZSTV.39HPITQGOG1YS@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI0SXNWQZSTV.39HPITQGOG1YS@google.com>

Hello,

On Thu, Apr 23, 2026 at 08:03:51PM +0000, Kuba Piecuch wrote:
...
> I don't like the idea of maintaining the separate checks, precisely because
> of how subtle and finnicky they are. I worry that it will be difficult to keep
> all cases covered as the codebase evolves.
> 
> As an optimization, we could skip wakeup_preempt() in local_dsq_post_enq() if
> rq->next_class == &ext_sched_class. That should make the performance impact
> negligible in the common case, WDYT?

Yeah, let's do that. Please send a patch and can you also cc PeterZ?

Thanks.

-- 
tejun
