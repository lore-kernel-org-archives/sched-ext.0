Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21D237EFFB
	for <sched-ext@lists.linux.dev>; Tue, 21 Apr 2026 06:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776751769; cv=none; b=NE/MwbTtD4hQXtstGAUJV9SH4P0b2Sp7OollF4IjJEtrLrh8X38LgdsnJ00vhs76TCaDY+lwEipSjhdJOUb+AVZLH3rtJ8rJ/66uBjOETlqIKycDKmhAcBvKZW2Xk0bmzslqgY1SHPBiSCssdxj1EacP3vmjtAJ20MNKRtoAPVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776751769; c=relaxed/simple;
	bh=ntpk3p6qDpojbygT6h3RmzBCzNBlgUC8xAr6gKmIV7E=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=VglJYrTddCh0yrjd+kof9mtuTTnyfeccoJKSqXqvQvaAYXZj7I7W1eJJVDS3IlGTmQVFLZ7aVrUiG86qmEyuAC7JYecseAdysXqRZXaAN82mj0pq7H4BeFESu6G/mzJwcDXqfOYr8QjhEQt8J9fOLxUsJgvcqOWD8I8y4siwieU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS3DcN7U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS3DcN7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA0BC2BCB0;
	Tue, 21 Apr 2026 06:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776751769;
	bh=ntpk3p6qDpojbygT6h3RmzBCzNBlgUC8xAr6gKmIV7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NS3DcN7UrxvdqMZLkQMVWwCqNSEEFrsWflkGD6LlbuNuE1Y/fQIJvKeTIVPSEJmuV
	 mJL3L4ig7KbDURuAWle4x0awIpvKgWq5CkkgKhAIMdLamYKo2W/E2IuBY27Xoca18Y
	 RwAzOV6aQeD8znGcY9K0nek/3y7AC2yUpMI44KFIu+7aHX+IWixVlI9fIGbVq/ozbL
	 I7kgaa9kVzcdq0Yu8RSX8BTMCVRW1FLmgj9jP58jduV22p8rvQCXYz+ppyj+cHTo90
	 PcDdz7FeBbFvy3AJX64MsDMMoL2y4YCAdpHNVsFQIo/rDTuspXVfQ2vFVK3Fo8edYx
	 +e2S0hfhwfCyQ==
Date: Mon, 20 Apr 2026 20:09:28 -1000
Message-ID: <dd718cf90e8fb2b54730b0f3af542e65@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.2] tools/sched_ext: Remove unused nr_cpus in scx_cpu0
In-Reply-To: <20260421053141.550803-1-yphbchou0911@gmail.com>
References: <20260421053141.550803-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Tue, Apr 21, 2026 at 01:31:13PM +0800, Cheng-Yang Chou wrote:
> The nr_cpus variable is defined in scx_cpu0.bpf.c but never used in
> the BPF logic. Remove both in BPF and userspace side.

Applied to sched_ext/for-7.2.

Thanks.

--
tejun
