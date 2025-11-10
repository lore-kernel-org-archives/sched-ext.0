Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3B623E340;
	Mon, 10 Nov 2025 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762791752; cv=none; b=s6SoWbcgugrJSfBmzzPKSxzqGOjUUo+RC8SeBilWrK7rg4SBu4dBhWy9ekrLAgv7hfLB3Pwdp2mZF5yk+252flKPham3dizw8lwSHN7vrVqlgUW340Sxh8btKyd+VIIKI7TIpsyGuELEal+Z30HQZcOq1RA6yGJTMZLzWIN060I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762791752; c=relaxed/simple;
	bh=7Yi7/eAJdF0WRqAilUrUGH64dpViOujUNV9Yz2ZA9BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YS3QGxkAiwyglXP0fztyrEApN1ThldLSQNAtTKfpu4Q4hqmtH6vR2oE0N3oJwK4luRwH8GqXxxNsDhK64iBvo/3vXfeZu4qf2dJ7SuQ3EhBHlzYZsLM7Yqm9wp+bk4HdcCC8eNFyT3TQOFqzhINSxtZKRw4ylzb3h+TtfhcDCGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTnHkDWc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTnHkDWc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEF6C113D0;
	Mon, 10 Nov 2025 16:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762791752;
	bh=7Yi7/eAJdF0WRqAilUrUGH64dpViOujUNV9Yz2ZA9BM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WTnHkDWcCoffOZTbSWEWa3tt/B0sXtSVAOjqDzk5NFd9YWnjIW6F9b9t0Tr7beZXY
	 t2AmDjo7OoUMqtCzfEnA9seTCyX0F2CPp9+D896BE0R1cdMH0hiC27JLcxuF+Yfp9W
	 CVd0GmZszVjRnfKaiRUdaznsskIU8Le7Ywr1WK+gVn5NhGo/nHPdZvy6nqpTb4Ozxn
	 EcjxOAhqdgw6VQbYC62eJBCRwrEeyTeOXt48ctS+LcSR4El2M9jsskCX+lZc9B4u9G
	 hQWoaWmxz6HfgNlQArWwGt6NkbStXVisCVCc57zkBlVY1m4zFNzWv+tiWdsTH51R1U
	 ZRxrqYUXtCj0Q==
Date: Mon, 10 Nov 2025 06:22:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] sched_ext: Make slice values tunable and use
 shorter slice in bypass mode
Message-ID: <aRIRR0hWpd5PKUGk@slm.duckdns.org>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-3-tj@kernel.org>
 <aRGOSSN9PiCBCoWy@gpd4>
 <aRIQ9rptcggpUVft@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRIQ9rptcggpUVft@slm.duckdns.org>

On Mon, Nov 10, 2025 at 06:21:10AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Mon, Nov 10, 2025 at 08:03:37AM +0100, Andrea Righi wrote:
> > I agree that slice_bypass_us can be a tunable in sysfs, but I think it'd be
> > nicer if the default time slice would be a property of sched_ext_ops, is
> > there any reason to not do that?
> 
> My thinking was that a scheduler should always be able to avoid using the
> default slice. Even if we allow the default slice to be overridden by the
> scheduler, it's still very crude as it will apply the same slice to all
> tasks. I'm not necessarily against moving it into ops but a bit unsure how
> useful it is.

Hmm... for now, let me drop slice_dfl knob from this patch. We can address
this separately.

Thanks.

-- 
tejun
