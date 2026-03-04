Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED54372EC3;
	Wed,  4 Mar 2026 22:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662190; cv=none; b=Ca0QJnTwsigHRWql95aiGXdnZGpnNbbZ74O8DrFqbP/yPSTThRcdLWe8m8LAa0J+I+CQjFPCrNh4xqCrfJ5d4TBCKFeHZJxZlMmpbOXecfeDMrSGiBQ/mA9dl4+WI4O5IjurEKxbcLb6DU7bDG1hmPSVUSVOO/dit7ZMc1kr6dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662190; c=relaxed/simple;
	bh=e1h0174GTM/+x4aq3PSRfcBme/rg+4UKuKBELx3ateU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iecu2/h01SfcfTrcpf1GSjCXvlllAR9gj8xqavF5bdxiDpI/RlouAbe7uBSZRG30oTG1DfGdv3OGVk6PKnN1kAuXv2j/oyxuoLUNFeuiaAVfhY3iwac3oms6lr5ZlMZpg5HtSO8FulnbLTPPjzoGwq6VgQRz8PfMAdJ1seQ2vJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCv7Nd6t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCv7Nd6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13D2C4CEF7;
	Wed,  4 Mar 2026 22:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772662189;
	bh=e1h0174GTM/+x4aq3PSRfcBme/rg+4UKuKBELx3ateU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VCv7Nd6tP5tmbQKPrbY83oYn1ah+ZofLDYio0E9+9TTtvJDlZtAEi0DoTSvfv2oqE
	 a5xWF+SDKDTWUdl22j8dc1mp4CJOOWEhsIePCjfpw1PgYL27pI+0+O6ja9JUiQJeXj
	 h/l0NDK1Dw2aBrQtFyh4Sg4PpyizoYL+kvwRAHWbfHm2HjXghArY+azc6wUbbRRLxf
	 LFq1RInLAYIa97om4mXCYjSq/IZwwELHb1DDGBlU+hIxx9SjbfTOGC7wW4PaKUcfq0
	 0H3vmljnAR9U9f9gqcHEtWQxQhgT/xZzknHEkAtJ7eiAlnxUBLtmdRqt9lSNXSij4y
	 yOvf6t7YStEAw==
Date: Wed, 04 Mar 2026 12:09:48 -1000
Message-ID: <c0e903d1fcef15b412a473760ef60188@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 jserv@ccns.ncku.edu.tw,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext/selftests: Fix format specifier and
 buffer length in file_write_long()
In-Reply-To: <20260304195757.688275-1-yphbchou0911@gmail.com>
References: <20260304195757.688275-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

Applied to sched_ext/for-7.0-fixes.

Thanks.

--
tejun
