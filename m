Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9D4C148;
	Wed, 24 Sep 2025 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736826; cv=none; b=GQ+QYcuYH3/xGKbvGDdiP5d5s7Gv0d1z9UB4brRqYc6+d46AR/v3oS3mcYQt1rk/8fDyl2L6PLoQ630AeWiSFmwHez57WTNOIDJhj4iibSFobj+kdpRP6e+XtsBmJ9VkJ/TbAXJC8xpbfyCSV1u9EjhnIkMiJ6YR5fyy0yM1WhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736826; c=relaxed/simple;
	bh=WgkT21fkoe2xkQsfdSMkINbWg5frLnfYwMcAV8G+cgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKD5fr4UEezS0fLVzfx6jGNL9Zf4+x566lbekkQ8NQ94MyafGw3DIqG3GciFmEBCUp25Taw1379OIAN1wMZaFqYZYoDXRwE6H/rPLRBqlHX1v9kd6p/DLmgO4r6gvollrGgTDL4AcTal8ecB9G48577Itn4mZ9uAgwcpgNBnhZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfm8C6YX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfm8C6YX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F6DC4CEE7;
	Wed, 24 Sep 2025 18:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758736826;
	bh=WgkT21fkoe2xkQsfdSMkINbWg5frLnfYwMcAV8G+cgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qfm8C6YXFMmKdFgUiacqksJSr1ZdBXuq7k3UWIjI8tND7IjbJJlQ4DVlxSpk1wu4Y
	 rgj0L0HIQyftnswTHssY4cgx/6TznXAfpmQbltqNxt7wvasQq6XlTMRkACGktqJCSM
	 PEK8fyaM9kGlt6otB225E/ApGEqwe0DLi+Ap1QwyuCLl/AwJ2YpIv4eP72MQ8yXN3v
	 0J9BSh+CJXT3j8QP2LSpbb6Ns+DPkLv+zeEIUqusmowsOht3aU+qsx13QK40pe8YYT
	 edVE90bcCUgjjwJOdU3N8UHybGt4Yvg9NWMswAQ4IwYq/4cbA4Grq3J1iJy7femdM/
	 RN1y4KQn2P2ow==
Date: Wed, 24 Sep 2025 08:00:25 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 1/7] sched_ext: Use rhashtable_lookup() instead of
 rhashtable_lookup_fast()
Message-ID: <aNQxuZxB2U87E7kE@slm.duckdns.org>
References: <20250922013246.275031-1-tj@kernel.org>
 <aNOMK1gk9if3UTgQ@gpd4>
 <aNORzVQ6OVkPHAjS@slm.duckdns.org>
 <aNOrMNYJipF_nTGD@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNOrMNYJipF_nTGD@gpd4>

On Wed, Sep 24, 2025 at 10:26:24AM +0200, Andrea Righi wrote:
> > IRQ is disabled, so it is in RCU protected region but the lockdep annotation
> > isn't happy with it. :-( I'll revert the patch for now.
> 
> We just need this: https://lore.kernel.org/all/aL_4gCJibYMW0J98@gondor.apana.org.au/
> 
> With this one lockdep is happy.

Oh yeah, we can try switching again once that patch lands.

Thanks.

-- 
tejun
