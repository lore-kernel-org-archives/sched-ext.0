Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD6F3793DD;
	Tue, 21 Apr 2026 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776789576; cv=none; b=tKDpAkK/I6R3AJmhK2snK6va4AO+iLqGkb1oSNtJeWr3otomt8K3ryjGMYcxO00n3txW89WZRzK7wTo2Yqg6GCx3t3IPXZgx7zv4/9BDt2ECY9qhzqm9kp0ZX60BHGL1i4PxhTsKsLQ43cyKZa6kyHxD8LyFbPEIoCergKOvza4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776789576; c=relaxed/simple;
	bh=RP+mUcn9Y+V1ASAIYPT2d/5csbhAXbxzcYsGMpsogPg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=SKHwsri3XqDiXIKxVVVbXvjZ0L+5zsQreTskfbRePIXTO9jEULg3mvklbtPY8saXyQOXaJ6NkdDvuvrFkEQ0VmNCNGmTzWmlBWLTLjf59cwe2+0riRKZEjYHJGUx1Abt3O2TsIfGMCxoZVqutZIrcA0cZGnRQZMLJt6GBsvmEog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXpNqYrS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXpNqYrS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408FBC2BCB0;
	Tue, 21 Apr 2026 16:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776789576;
	bh=RP+mUcn9Y+V1ASAIYPT2d/5csbhAXbxzcYsGMpsogPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IXpNqYrSIp0lFxczdfkGPu6l2ktFuGET69HZhFwcIDyzaHkccD3+hLo0amUX/xuw9
	 GJXIAlGh0jE75Q0l7EWHwXO0XDcXxLkm2XUuXH3a8+c20cXEYnBKBpnpm+MDM+Mo4k
	 PiuKlMmAOro9xfNz4K3Vz3dPNOrXanBUr9QqKxkBekTDVmHMxsIhwcyBWVvtb0iJ+U
	 sIoJN653QOr1GkAhIgkQkDSCNFAXRO0lDlUWgqSxQEI3iKLEXUyUcgOd1wE8i7Z1dG
	 YfrAXcRSchjmZ4HXw7Ah8JbSCDseGBzJYieX/bGZ4+h56Eu6H1/7gDiyKbFd8nHMoU
	 l5E94gy5BcQ6w==
Date: Tue, 21 Apr 2026 06:39:35 -1000
Message-ID: <9f638fb96e9bc3a6310b3b5c9b4adbd7@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Subject: Re: [PATCH v2 sched_ext/for-7.1-fixes] tools/sched_ext: scx_qmap:
	Silence task_ctx lookup miss
In-Reply-To: <20260421071711.3108449-1-tj@kernel.org>
References: <20260421071711.3108449-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.1-fixes with Zhao's Reviewed-by added.

Thanks.

--
tejun
