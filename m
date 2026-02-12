Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B6D10785;
	Thu, 12 Feb 2026 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917394; cv=none; b=EioFpXR6TtO5JDyaKHyhNbH1fQKaGyCwBV726n9a6aj+nngrYfresHG39IRe6ruvSLTmurMNZ8DN0FKecrcyvqqLTma80BwGqqwVtAbxZK+BdiqXXF8YL+iDVtkmy4qklSeOcD8ji9PwG6C1NEIWPPuuct5R9pL3J1vakA8Tazw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917394; c=relaxed/simple;
	bh=zBKDYKNoe0zhTn7wyrSVwgJe83mJhxcxsWU4yEkRHtQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Issb1g1LtK/1StMApiRVy2DLQLehJ+1FRTef62uqscNxoFclaPJw3U2qyw0qPSCxIHPrz7EsDTKtA67Sd2qk6blXy47ywd76R/LS0+IrpWtkGnewWWpohkL1QIltn9z7jexY27u/DjDvZoOffAY6oTCIIZwD0ZovT/DY0Itqkrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxlXLG/X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxlXLG/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F59C19425;
	Thu, 12 Feb 2026 17:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770917394;
	bh=zBKDYKNoe0zhTn7wyrSVwgJe83mJhxcxsWU4yEkRHtQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kxlXLG/XDCqFXyvtOW7b89+zQNgbK3ePgbkaBLgwVRBHUVJKzMX61YUUSrdKtKX7n
	 ctawYQLiNO3QaqxGOSHs4ZivccO7plynGkq7/Lg1DgQof8pLjJAQDJd+X3wqj+aEcT
	 QFE6Vgk6ntWstj9ASKxUO8rasYtxukZKytm8vBTJokDib1/z65SnDvzqQrpesXSJq7
	 TuJ3feg3IWKvQD6EsAMij/70L9odGtUyMXvfEVgpon+tSzCBknUQp3IOBmri33UwwY
	 doH+uhabWbqGUoeYX2BkjHHUDzrizvTf4o7zdJoJAqC4vmZ15RZW8lO8gEurb/Vfh4
	 sWNCEuvs06nig==
Date: Thu, 12 Feb 2026 07:29:52 -1000
Message-ID: <34d110172c54cac54e44f43196129ced@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: David Vernet <dvernet@meta.com>,
 linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] tools/sched_ext: scx_nest: zero-initialize stats
 counter array
In-Reply-To: <20260211215213.917724-1-devnexen@gmail.com>
References: <20260211215213.917724-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.0-fixes with the subject fixed
(s/scx_nest/scx_flatcg/).

Thanks.

--
tejun
