Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977122C11CA;
	Tue, 17 Feb 2026 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771311867; cv=none; b=raAMqz8OViw2ET+0iY7sXtrsNg+ABvxnIand2X0FxKwy5Va/6EvL1WqiNJ3ysKZhx6XUNdZATBPND2490b8vtmqFzy9chVTJUVc9vC5W1yD8hvU/tMgugvlGtNqzQTAmSONROn2mxmPYhY0RWbu0Bt9rU3yCis9iiMe2TWI5zk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771311867; c=relaxed/simple;
	bh=5NagxTo3Ayk8aDOjRx1exd5cvGSmdsLcX3C8mPh7Cho=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=kco4392GhGSmFGqitRBy2yLv7EG1D4kyx1TSd6jIQSG0pGIjHzvMAW0vBauMYp3HSyi+F+/x9d5K5w3TMJoahUl2P8IrzPeZIBGf1VbvogqJjR4PozYgrGhtcaG0nO4OT4P84Wv8E4f3IoeFZGvdEpWWMwWsweZyy9os5nHfDXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jg7zv5Cy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jg7zv5Cy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5474FC19421;
	Tue, 17 Feb 2026 07:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771311867;
	bh=5NagxTo3Ayk8aDOjRx1exd5cvGSmdsLcX3C8mPh7Cho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jg7zv5CywjV5/vl4x3X19n5J8Y6E9NF07acsNZwOsp+Cz9Bc1ZYGkydj7k09jYxnr
	 ABx8mzp9o4n01kvRM53eFKkFHvi3s+lubZR1dlUv4CEuDAQN16k7DwO/WMYM5Lqec4
	 klm9JYZdtEiXYruknSI1IRAAFf0xWb3q6YRZYYMARYnSWZHrt97scUgR52h/E6tDDp
	 VxLZ8C7iB0OmrvA3B1y2hDYXxWCRs7Lra+gvNzIDinQNk9sopNmqv7P0a1QnXb/aBb
	 lwSkPlKKAUk3a4pT3X+hJ2m7Kg+/Wht4SuqQcCRh7MYwJVkhAEjnYMVn/F+lqfIL3y
	 D+eah6O7RSltg==
Date: Mon, 16 Feb 2026 21:04:26 -1000
Message-ID: <046ae56df6caa9148b1121b385d626fa@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: void@manifault.com, arighi@nvidia.com, linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev, emil@etsalapatis.com
Subject: Re: [PATCH] tools/sched_ext/scx_userland: fix stale data on
 restart.
In-Reply-To: <20260214080033.20240-1-devnexen@gmail.com>
References: <20260214080033.20240-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.0-fixes with minor commit message cleanup.

Thanks.

--
tejun
