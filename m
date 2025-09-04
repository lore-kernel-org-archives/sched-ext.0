Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D2B277C8A;
	Thu,  4 Sep 2025 06:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968280; cv=none; b=MRuFK5kE4EpjEHDywB9N+eYs7KPnmpfAeiADV1krz4d7qcJUw33tf6XmzLS+ibdANOce1NKKVk0OxPSXlHsXBYBnAihi1hBmRTUadR0rFG7dIwaYo4tWu+5kiUuyjY3JyiLyjNqh7wIMi2WIceZmX3vLHopg1QOkVkVIcBxNpvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968280; c=relaxed/simple;
	bh=w7mBXlGrJ7ClDm3km3OkaDU5N9eX5xsGj4iZnVdAGaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYNkZmO8zsTY2vQASg3q1sTii65wATgeOVGZdJIduTXchdL2lgDP9xXBORzA8VwbTsbpy42XH/W3KNqLu7ilbzfuLjZptwoBszIWMyrEFzgra1uGIDtR5HHQedXujoPmgEDMIp0axNVsHivIDP+QaotvJGK6yJ9/neZZyCdxALc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TypBgGCp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TypBgGCp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6787AC4CEF0;
	Thu,  4 Sep 2025 06:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756968280;
	bh=w7mBXlGrJ7ClDm3km3OkaDU5N9eX5xsGj4iZnVdAGaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TypBgGCpCRPTCUzG5Jwtud08PBVYzfSznk7yHnk6L5dn+xO3DbURmKS+k99KqqWRd
	 99ESFk2prm33FRYte8tnG+DwOf915d3qzKCyM7vazOdALl1IAk4wJtppo+nMB3S/nf
	 DB6xqyOsaTw5urdoDohYxDTikBU5xd/PChIKlMDjUPgsHSo1zIJZb6UUnG0VS0OYio
	 lfmfzx05hZng/y9c4oKyuGI7x1mT2Ve8In64Rl67MHe7IiYXnaIbAFmlcgFWfieVLQ
	 nYuE9vSMGLm3X+P9KyyujVTdNjvkPg28mRTXuh6hu62kVis1CdRuJIV4u3qbEtXUVw
	 wpoYM1T7Sq+IQ==
Date: Wed, 3 Sep 2025 20:44:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.18] sched_ext: Exit early on hotplug
 events during attach
Message-ID: <aLk1V2MEkD7uMgsA@slm.duckdns.org>
References: <20250904055716.87268-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904055716.87268-1-arighi@nvidia.com>

On Thu, Sep 04, 2025 at 07:57:16AM +0200, Andrea Righi wrote:
> There is no need to complete the entire scx initialization if a
> scheduler is failing to be attached due to a hotplug event.
> 
> Exit early to avoid unnecessary work and simplify the attach flow.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.18.

Thanks.

-- 
tejun
