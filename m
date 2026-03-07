Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0CC3A1E9B;
	Sat,  7 Mar 2026 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772896301; cv=none; b=JejHVAkWrxUng8RsxvpQGaE2YUKNBPD4AQQMriBoQg2meJF/cnZHpbnt8Ddv1zPGtxk0Zed5VyJpbza/iFDVwgDw5MX8p2IzI8fCZS3SotagTE9v7hqaqAt3sG2J+ttk+tF7GJJD1iYHnlaDcXZ6Kh8P49Ub9uH+qKzFSY+b0J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772896301; c=relaxed/simple;
	bh=qoBvL1DTRrlpmApXw2d1DP+zGpcOwEj+jgOKN9a1TRs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7X5eq3ld+3W3iNu2YNWDRODh4eV54QkwRiCntqvAbLPUdkX8tkpPx8XPq3AYlmutn/QOHoTQgYlKpwfNdt559VqA6ytjmYhEaEfVpmFtXs1eXjQKYL90Aje1hqKIwUwbZ9SMd5WPsHxMA7rmQPxvr3n7+edBkLEFBF31zzM1HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6gJssNl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6gJssNl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F61FC19422;
	Sat,  7 Mar 2026 15:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772896301;
	bh=qoBvL1DTRrlpmApXw2d1DP+zGpcOwEj+jgOKN9a1TRs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j6gJssNlyBKzHc6UKHbyzOViQjrunCySx/Mhmc20mpHCpgXXMA0kwnSzuakcg0NGv
	 5IkG9y8YSAH3prlZH7CQQaxLmA+k8+Xc9OjV2R2MXhfpMGUSIaloE8O9suDuB16mEX
	 ewYWosrlUi457O9mhrLZoM7eZ5dK+s80Gdbk17OKC0h1aGfTV1EkxErx0COkMZWUE/
	 zRipRYTrhRw2ZukhYQGPUiXbtHBISB0NnUt9waHVLTKpvYG/5BlwsTXjNFsgfdAkhZ
	 CQHDdFHVKNTIp8zbX8NGKhjJu/waC0chKCoXvUcr/9dof18QbUGlNEcM/DljiVhhn8
	 82mZOBjLS6fQg==
Date: Sat, 07 Mar 2026 05:11:40 -1000
Message-ID: <959914e22fcb4a7145ec4c40aadf4402@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>,
 David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 Daniel Hodges <hodgesd@meta.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Pass full dequeue
 flags to ops.quiescent()
In-Reply-To: <20260307095631.74437-1-arighi@nvidia.com>
References: <20260307095631.74437-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Applied to sched_ext/for-7.1 w/ Fixes tag hash fixed to 12 chars.

Thanks.

--
tejun
