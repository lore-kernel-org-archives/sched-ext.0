Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1B9171C9;
	Wed, 15 Oct 2025 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546849; cv=none; b=bkKynDixI7cQ+okHZYcdsL6OoLdPx6zuoqra+WVKDXUw96NknnCM3/pvt7wwL6jCf7ovtJvjsXMFNwrS+P0+TECU0qmDYXk+9DNo1gFYuLS+L0uwgYQijKUNAHyJX/Ut1tvuTIHBLIoJEvr3oazg9Nr5KeSOhGpTJ/5XyBIcVdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546849; c=relaxed/simple;
	bh=U6IgK83O2vNXgtsQ+2eQScVJHl6RZaEymwda1yEGEO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBh+H+eyX5Ai3jSEpWTnq3L6DBf1Y28bLm8Ne58O2yp3Sx1pC/lu1COs3LBSy/A0PaeLipc7uRMr25JVpSLQFVyMskWeYej+tCbNOcm1vUvXd+9Wzk9d0k0ShD0f8GZlj9iUt/9//0H9Y3VYSre7gYs/HvKRoGupuEtyxXGt5OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sl2MUZ18; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sl2MUZ18"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575B1C4CEF8;
	Wed, 15 Oct 2025 16:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760546848;
	bh=U6IgK83O2vNXgtsQ+2eQScVJHl6RZaEymwda1yEGEO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sl2MUZ18TBMAA73mMttpIBMluujUTeDOuY6XR4KZfVFwXf0xDv0vB+XL0uMFz+JR6
	 eYEAPzZuOx9t6zYkDTGGU/guwcEBgCVlegnArFbu1xcm/uz1UAh1BDKXY9HwyTfyzf
	 z+lbGs+fEeYd6H/Vk4CyP7HQFmcFdiUXBSrCOpEqQJFAJkua1UliKWdB//UPnn5QIa
	 Ko4IVgP0XScVhEzBHwJ9Tur4LDXVhJ4HBDNv5Sn++f9mAOI/6bKPHgp/jaE6010M6+
	 xQTK3QMSFxYBgwrjh6HJgeYEkhOUVVVLHdhxMB2R31O7ZCzqb+rJwWvQmB8MoN/v9W
	 +U1T1Ix7t8q9A==
Date: Wed, 15 Oct 2025 06:47:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Ryan Newton <rrnewton@gmail.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	arighi@nvidia.com, christian.loehle@arm.com, newton@meta.com
Subject: Re: [PATCH v5 0/2] sched_ext: lockless peek operation for DSQs
Message-ID: <aO_QHzbw4euzD7T7@slm.duckdns.org>
References: <20251015155036.420486-1-rrnewton@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015155036.420486-1-rrnewton@gmail.com>

On Wed, Oct 15, 2025 at 11:50:34AM -0400, Ryan Newton wrote:
> Ryan Newton (2):
>   sched_ext: Add lockless peek operation for DSQs
>   sched_ext: Add a selftest for scx_bpf_dsq_peek

Applied to sched_ext/for-6.19.

Thanks.

-- 
tejun
