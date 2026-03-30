Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DEB376472;
	Mon, 30 Mar 2026 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774896974; cv=none; b=Uq7OfAzknJpnVmbTJsklT3tmY69+9JXfWfl9T8i9o3c5QwIWdPiWOBVftO4egxoGih8GqyEqAI4EZTNuVdmpVSrmzdtKhELOJgTYTlr/LZAnR6/mvKfCR0gXaTg70VU3Ap/t5Hhs9+7pBCocf9/slPctquKtq1ZniGlMpYVx3jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774896974; c=relaxed/simple;
	bh=mpOiPob2cLegbTcTGts45PmW5AnR9DyCNR4OWHsfn0Y=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=UdipjWGKEr+lSDEyswQDXfyTPs9QTyGvoNXMTDoJVgwzLjT/XzG859muPJG+p+JEKQgZa0LueWZ1dBexkeDHvlxauaYfusHfgmfY5m2L8eb6QmOkv/qvbm3D2KeA2CwC7h8qrRG9FsUdPR2ho1u46u5U7GI4ZPqj93mMsUH9hpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xnx3ybPK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xnx3ybPK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6532AC4CEF7;
	Mon, 30 Mar 2026 18:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774896974;
	bh=mpOiPob2cLegbTcTGts45PmW5AnR9DyCNR4OWHsfn0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xnx3ybPKIdQZBKtTE0Qebr3rigqG9bRdliws+5tg9scl1ucN2dTvsE5cvlZP1U4UL
	 w7tI5hnfubLOQD7yNxEhY0ApDg218pL0PmkIlaTzFP4gXmAP2XtczdjFoGYUQvXy+K
	 UDkajtvGUiDMa2e0uzYXCmPX30/aoUqK2KHI2QylZ5HXvZ7nWsfx/Ty2L3sedmq1Xr
	 RLhNuXaW3wI9tX+sMVGzI0+4m3U1IcvCAP0cCM8j1VQ+ORrqvTmga9e1E+0DfMAw+r
	 Ko4FKVAuoBGR2pECqJUkCcrvLtPiXycKmWPTSlACP6wZL0hiHH1qdGpi5AFeXuo70u
	 maHltE6yBk48g==
Date: Mon, 30 Mar 2026 08:56:13 -1000
Message-ID: <93c2a16a72d37955cddd66f4f9f3b102@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.0-fixes] sched_ext: Fix SCX_KICK_WAIT
 deadlock
In-Reply-To: <20260329001856.835643-1-tj@kernel.org>
References: <20260329001856.835643-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

> Tejun Heo (2):
>   sched_ext: Fix SCX_KICK_WAIT deadlock by deferring wait to balance callback
>   selftests/sched_ext: Add cyclic SCX_KICK_WAIT stress test

Applied 1-2 to sched_ext/for-7.0-fixes.

Thanks.

--
tejun
