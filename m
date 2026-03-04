Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476863A0EAB
	for <sched-ext@lists.linux.dev>; Wed,  4 Mar 2026 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772646633; cv=none; b=lGRwtdSQi/VxQ374WbcYJ3cKIeV1D7+bwvDSx/UsdumwojYmV6IgcDCGcmkj/xQv0qVVdM7vppO58H+7/2UY+tuLDPZ1pcM0dxY9YaP9TqofQm+6/gJrhB4d0FqJYM0WvzdE2N3skz9DKFPVK9U5fqOowHhQ+bOdFnmIL0vQzmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772646633; c=relaxed/simple;
	bh=b7cPTcd87efQDzYM6H4DT8BsryB3tBlDaBfPS0kCgoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvC118mhT4gIw4zLhFp4CjZ5Uh13wcv9tSYvtgiZja56hEl3FJqRCZWmrVdzIpE2E+MUF5+JrdOPapvorDY1Zher9qS8CJqCGfFRlLvfYd7r+cDU+vyOZta4dVI1xQLd8gWFTCJSXgZakeaNsqxUfECwMQ38r9Ew4Qm8O9Zre2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OB0Qw+OR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OB0Qw+OR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C031C4CEF7;
	Wed,  4 Mar 2026 17:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772646632;
	bh=b7cPTcd87efQDzYM6H4DT8BsryB3tBlDaBfPS0kCgoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OB0Qw+OR37PsEIiyiyaZEfmSB18Y0PRjwre6E97hYlCRxvRuD4XMx/Xcwh3qCuMx7
	 hG052fBQynV3zsQWQEATXUDSk01v9oLQBh9zILYQiQ+NvewEVGz9Wcsp4LKVIobY9X
	 F9haF6wagMC41UTI6Epbf3YUcBUSf4lDcGdrpeJGSuKQgTNL6C6dx0MxGn5lNw4ZZk
	 7/FLFLOHxISseK9qs7TJ1hulptXb4oomzqPxGM/9hBJ/4xOViroA0K9fpyOIvgnCpV
	 JR7ZpVuwHyza3GYpzAtf7NMPHGmRfOC0DpVG6CEen2tWVfAkebl3t30gGQ2AVZMuVB
	 SPeJA0JdYmFRA==
Date: Wed, 4 Mar 2026 07:50:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] sched_ext: Add missing braces to multi-line blocks
Message-ID: <aahw51fT1ANEhIUh@slm.duckdns.org>
References: <20260302071332.3957905-1-yphbchou0911@gmail.com>
 <aahoG6u551ACsILA@eric-acer>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aahoG6u551ACsILA@eric-acer>

Hello,

On Thu, Mar 05, 2026 at 01:12:59AM +0800, Cheng-Yang Chou wrote:
> On Mon, Mar 02, 2026 at 03:13:32PM +0800, Cheng-Yang Chou wrote:
> > Add braces around outer loops and conditionals that contain multi-line
> > inner statements in both ext.c and ext_idle.c.
> > 
> > According to the kernel maintainer tip bracket rules, brackets should
> > only be omitted if the statement following an 'if' or 'for' is truly
> > a single line. This improves reading flow and prevents future errors.
> > 
> > Link: https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#bracket-rules
> > 
> 
> Gentle ping on this minor style fix.
> No rush at all, just making sure it didn't slip by.

I don't think these trivial patches are useful. Ask yourself, is the code
meaningfully better afterwards? Maybe as a part of some other big changes,
these might make sense, but, by themselves, it's just noise, a busy work.
Please don't send these patches.

Thanks.

-- 
tejun
