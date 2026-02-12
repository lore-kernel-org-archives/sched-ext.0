Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8824B1E9B3F;
	Thu, 12 Feb 2026 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917498; cv=none; b=n1QtjrwZUTmmiQwu77aQQ+eLKVlvOsTKrwS2YiMaloSaiL2+ET0oRn6Gl14o8e0RyIscGzwWYsK9yregIUZ7hi6L/BoxPJ6repRf1iSHpRrEONiaAgTqMmE4e3psimvx7y3Yx7nm6EsyhCIfhF+n//nv0LYxkJzwVl2yY5WOAs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917498; c=relaxed/simple;
	bh=JT+RFfTayO5DShJukirFxUaq0lwtYyL+1kZfRbdneeA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=rNo+uK80BhrfNV3GME0+hakoa4H0KKuyIvWTAMfygTOO079ih4Nko1yyN0Hd42a0Dn22tdN33g5cx+jCSjRjvAI1O2cXwt0woybFQiv1g2szesr09FOh3UvMVJRsWKBPoQJ7OgTGCyJLr11tkBiM4hSX02Xgs+QRjrbGSSdZvko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QF0l7gaf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QF0l7gaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AF7C4CEF7;
	Thu, 12 Feb 2026 17:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770917498;
	bh=JT+RFfTayO5DShJukirFxUaq0lwtYyL+1kZfRbdneeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QF0l7gaf0OGS+G2CjSTmwWIT6gbe5Pg7TNnvgB5+CFUfd2y0jz3/8Y3jTy7xzXKtY
	 68E4MDROUk4uPw6zL/N3Onkdk3kQKmNVAUS4f8xbtQWwZrAL7s9B3X3i4Uh3IUsHSz
	 g6BcFOAr5g86Fy8Ior3egJZTXp/Sx0SePG4oglORaFVIJggH5NijHNsz9T0TYRb8mk
	 AqJnmkhPxYlLuiiShmv/AssKSC8seUySEH6+kGAVg1Gk7V19WeyAul+/4tL++Q1f0/
	 1YFLCRc7CxIWkyzKDqxo8jqdb+HwF5ax12Af0+wTSxquDs2xQhMEEbmZr0bdozoAqk
	 oIFYWv1jIkmtQ==
Date: Thu, 12 Feb 2026 07:31:37 -1000
Message-ID: <7fffda4104686cff0f535ecff8433acf@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: David Vernet <dvernet@meta.com>,
 linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] tools/sched_ext: scx_central: fix
 sched_setaffinity() call with the set size
In-Reply-To: <20260211213027.914485-1-devnexen@gmail.com>
References: <20260211213027.914485-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.0-fixes.

Thanks.

--
tejun
