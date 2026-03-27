Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD162BCFC;
	Fri, 27 Mar 2026 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774633390; cv=none; b=kHO4kQwQiWhf9U6GRaw6IgD5Fs15UbgQW4ugPUVbIWnENRbcyfM5amsuvqZmmKokPvwuA4k2RoueXh7vo+f5w1urdAFf+QFq8hQoU0Kf54o2ctLedKJyKw3nc8VrINc0yGf+a4ElW4R0c08+ljeC9XiaWdj5EFp1286JBdQsl1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774633390; c=relaxed/simple;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=jesw9tzCuyRTXCcH3jcwfuj/yM0FZxQQpM3XDxkex9glprT7X3J1hO+plLgQXA/0vrnLZ/NowA0gR4vGm7tabicqfADiEvf1dj58lAWPMPB6/6SMX/f9nhPBkfIeye349zdJATRvMAB7QqrrB5xnp1jjpM31DR4jjkgvphyE2BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCfMUc/4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCfMUc/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C06C19423;
	Fri, 27 Mar 2026 17:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774633389;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jCfMUc/4ShLs6+FgOfYOtK0SP852UpaCArCySPRsL36tGPaa03S4X7g6IpSZul5sN
	 f4sY6iZDbhQiNXgQ3B+x5QDbO4T7LFOcUKTWqfTNNBBxUh3OmUMQUz7OiwoCgx7NyV
	 N1krtP8cYTgkgHuzxKmOh9SEFAShvt0rbT69nLGMRHZifK/8YUsqTROyRX0cNOAjKJ
	 qSyHM0EzPKRlZX2H8nZozUw0/3PY82rj5qNzyVFVPNdNxn4r5OpSgaAdj7gWgfsj/p
	 b5AnNp5sPiNeDXCgHBcIgQ9kmp1pqHxLqI4NxjwZBPdWqgPYs9MUVvjyAkeUadxE6u
	 aR0BUnIeNmnJw==
Date: Fri, 27 Mar 2026 07:43:08 -1000
Message-ID: <e7cfcd7d6cc36e297527566c12eb8faa@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zhao Mengmeng <zhaomzhao@126.com>, void@manifault.com,
 arighi@nvidia.com, changwoo@igalia.com, emil@etsalapatis.com
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhaomengmeng@kylinos.cn
Subject: Re: [PATCH RESEND v2] scx_central: Defer timer start to central
 dispatch to fix init error
In-Reply-To: <20260327061757.252255-1-zhaomzhao@126.com>
References: <20260327061757.252255-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1.

Thanks.

--
tejun
