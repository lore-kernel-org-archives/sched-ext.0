Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CC3322DB7;
	Mon,  4 May 2026 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928743; cv=none; b=Pgbv/EZurP/NU5R+BEbVXHV+ZSoZ+g3qDpn10UQyGH7RwFSpDFatE3+ifTuTfm1fdFjn8e0z66h3Tsd8Rmw8zzrDGmdEE1HQn6DoIwbKqty1CYTcPwAu2/UNf6ZClNQuiNxfycjwX1TBD0M83tLDRV1ij6ytshGHmHx8p8gUghE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928743; c=relaxed/simple;
	bh=ZQ0Nh5rqtqiB+taGfMPj8Pjt7bRswEsPI9sgnfVXAKI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=k+4pEYoMV/z7OLAit6z9r+GJ/pSer76mkLgyPjv2wk1Z6HCPvnSPEnr2G6Xa5vtMlIwkiB76SuW7G7zuWRThT+Q4VTk1d/tC1lTEmn5+jvCVr8aGuxX0dmpDNfX3J598z7IpipTy4qkME4BZXu3Zk6c8zaHJZhr+oen+KV6IFgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVOn5tC/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVOn5tC/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB3BC2BCB8;
	Mon,  4 May 2026 21:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777928742;
	bh=ZQ0Nh5rqtqiB+taGfMPj8Pjt7bRswEsPI9sgnfVXAKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VVOn5tC/jU1FIzjhKdGyMgoJnsTNAEm9BTDti+K2oSBXdRdrTmZmhmO+twqXUvALP
	 cgWKT7QMPaky46fpS/Plh3dIke652PfY49wkx0tubbz/LdXMXLYW1XpC6jb+0P9XCq
	 1h2/h6SBJWtaVlgI5zBsGFFcQRsX5RFAHX/r/r4Df1YW6eQNCoUTfv1H2kh/8xBgLr
	 mGGSOazsgvOdNFEsqtcE5Rfx+5l3eLDsWypvdSBKXmi4TgD9DVbT3WM9BYWDRRU+rD
	 9p6tmPOIslhMBKmyqyT9maxz5slT0q15w5QIkyItn8LJyIhwLs7SdoDXwvFd/TAIsL
	 RH40AbluDw/9A==
Date: Mon, 04 May 2026 11:05:41 -1000
Message-ID: <20d4ea38932499d7fe3379d1410cbbf2@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Cheng-Yang Chou <yphbchou0911@gmail.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Remove redundant rcu_read_lock/unlock() in sysrq_handle_sched_ext_reset()
In-Reply-To: <20260430084543.25137-1-qiang.zhang@linux.dev>
References: <20260430084543.25137-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.2 with Andrea's suggested commit message
rewording and both Reviewed-by tags.

Thanks.

--
tejun
