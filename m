Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69D833C194;
	Mon, 16 Mar 2026 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683842; cv=none; b=GPEjV0xkG2uImaFjtzNWqdnTOIY+8yrQbHbw/j4swYMgFnQGWL8ujOnZ9s4ATzJMf5UA0/6jl+S81pPTUhyAuUKwJUts63ex4zkpmrthI47TRZx1UqMNiOxG6u/BLOytlVjclWR9q/6bYL/oH03skc9LPgpL5JowDgTGfW18nSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683842; c=relaxed/simple;
	bh=o9U4kP9BoiNmczBWmGX/rTwZTTh7SYM3gh/9l0lKK5A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=YgRIzrhZqZypreiickiStZB9OFGAXZohcnuTsigDBsQ00FkEca/d4MkIZm71thyp0/0GsJEH6x6pn4rHCGblIz0FabXA+HHov7LawM85YzxZbaMG6gSLGx3u54mLI+KRGZE+a62l0t3uR3VGsLox2C1Vkh+zOKP7YhYQbmrGdeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/+4N4y8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/+4N4y8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A826C19425;
	Mon, 16 Mar 2026 17:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773683842;
	bh=o9U4kP9BoiNmczBWmGX/rTwZTTh7SYM3gh/9l0lKK5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n/+4N4y8yNDywgsVYSkIfNB24nhhPnp6wnELekin2/TF6O4XkV276ncVz3IIQAbLG
	 fPjYRLf2L7/mmvcFxrpLwDg2lsRK793CtJVtqLKIWvRuvNmtF6nfvGZovVXcK+tHeT
	 1z8jIETvhqGUpJn/uIJwwVvGdFVeAadnyIv18E7Miai5Q2PAvJbRHMxwceBv4zqGBw
	 qqKqcg2e/XoZePUEMfi6NUiw/wNgzKjbzbv01jbdS3LhUjS4+lDN2Nl/1RbgqUvCGV
	 VpLVQ0uxMCVCcGGa1gD3ytLtzQVzZs1UF8la+hHQ4T5qzUP+m6SZNfMQFwynaFfW7F
	 tSKx5OzmFWtOQ==
Date: Mon, 16 Mar 2026 07:57:21 -1000
Message-ID: <0f025d9a43b207c3a40ca3d64b60e404@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Fix slab-out-of-bounds
 in scx_alloc_and_add_sched()
In-Reply-To: <20260316174943.82077-1-yphbchou0911@gmail.com>
References: <20260316174943.82077-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.1.

Thanks.

--
tejun
