Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108AE317148;
	Fri, 13 Mar 2026 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773401545; cv=none; b=Hx5D3JNSfs7U0ezbHrTs+M87JsVO3PMVySaoybfsqraGnW9+HGfBlf4U7lU544oBAlDqR26gfweJ4JfAwR474lbK05nl/mDFn0MTRV1SrMXLURf3UkDjlzqI3Co6iEl7xKqCuVD8pQ3sH4UG7uCrDpr4ZkOvEloGCaQ4OadBWo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773401545; c=relaxed/simple;
	bh=U125FAdfOIYlmoGRiGxDq63Ad1LzPdfeWIzdhqNm7Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EChh61egVlW7bSiWBxOb8YWrVPuwZPO3OZT46X2iCD/B2MUxFyaomarxNxDnomZ/++2valXzRhKXjTtdCe+d0vrGqgzAOM6ql1gQ5rbvx1zYJlmHihUYYHbT67eSm5wDnHtWg2JfQhVIx4JUdONWYKzrm/sJZCTZvD8/ax3NfXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiQT4lib; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiQT4lib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4DCC19421;
	Fri, 13 Mar 2026 11:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773401544;
	bh=U125FAdfOIYlmoGRiGxDq63Ad1LzPdfeWIzdhqNm7Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OiQT4libUYLBSQ0VpFrV5MvIegyYrVR2dDazHEfKZ79O4yRsS6gnvlkecr7Jd9Q/K
	 KDO4aRaHheqjuspgjnAPI6Bep4ZYwVY0pruG9t8P4D5IH5mX1tzrWO7C6PV8lwn0j1
	 Lx3QonWNeiPMgsAkmsr1UP/DP/hKxY3Xthy6cIudGZKkQkJswmkGkhZgVboiCEC5Tp
	 uYhseLo/Ar/E8Yqtnn0jhD+ZJpzbJaMNHh9waNULePds1Q+zYiVqtEbFFSP5rZtx/3
	 8vceAw/Aubix2XSDUvl5GVPLnwKjK9sGUXbMiMI8GYNmCAYUY3pgNhGuqdK4AytfB1
	 LQyokjFUSTkSw==
Date: Fri, 13 Mar 2026 01:32:23 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched_ext: Implement SCX_ENQ_IMMED
Message-ID: <abP1x6d_IW6Lu1lx@slm.duckdns.org>
References: <20260307002817.1298341-1-tj@kernel.org>
 <20260307002817.1298341-3-tj@kernel.org>
 <aa8E6WauTRALRCqs@gpd4>
 <abPpromdlJNm8DGd@slm.duckdns.org>
 <abPw_1OSCnQFNhcC@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abPw_1OSCnQFNhcC@gpd4>

Hello,

On Fri, Mar 13, 2026 at 12:11:59PM +0100, Andrea Righi wrote:
...
> BTW, did you send a v2 (in that case I missed it)?

Was just about to send it out. It should be in your inbox now.

Thanks.

-- 
tejun
