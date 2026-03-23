Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17A735F193
	for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288171; cv=none; b=BW6Ix5NPZvWD1l0V4pyJCs7GT9hfa9kZN/+WUbg9yyP4UV1xVuVa/B6D8aTPVAupdnazYY9hfrg7c+zIo0r3095mX3++RLvdw3F67UYK9cEfNHULWWw5bcNOGIhfQODoXsEp2sdqs1uSc/SF8cCD0c/ryHQWtTuRhD5o5XcAiXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288171; c=relaxed/simple;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=DG39TBdmhILbmlB52uspPc4N3iBPL+yikWJfalE1/ZEJiUBFo3S/IvBdB9o9ZXgqQAlvS0IrLHslvCEnlvKkAPcIVjC1YvCY/Bq89mGASuO6zb/UiRXkBDwFAlGdUyg77m4dhuincws+/T1Ma+lo/GH+Tvo/6ACOX6CmgQK9tX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4itVB4L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4itVB4L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C7CC4CEF7;
	Mon, 23 Mar 2026 17:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774288171;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n4itVB4L6hai7Pf/Pk49oOBXr5Ac0uZYn/zdc6SE+YJZW1mCA2aeX3auUoFpV8AZL
	 hEwBZ7H6UiitBfGEIkFhPiojcW6nAANRi9YSIxUjxHwkKtCnjJ2xzsTci8p9jp2zI+
	 nuBSx7iQ45iSvQ0kF1f/AGeYpn7bG8m/faL8MsdslG0eKH8fMSDTUDjqxSrHM9Zl8x
	 nYvLuGuF9lvAhvPHl8018ywL7/YZd3Nl/NJ4TxOhdNYgx7rmIfg4Bm/b4s4EgBIQMc
	 +aQe4US6eHx3YjhfQX6fgPm64CrSTyG7ng/tEFz9qC0Wpb5ThDwKARUr7J1WVRS2Da
	 ZMlSmze0KYaZg==
Date: Mon, 23 Mar 2026 07:49:30 -1000
Message-ID: <a54cda8f07dc766b8cd82485775014eb@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v3 sched_ext/for-7.1] tools/sched_ext: Add
 scx_bpf_sub_dispatch() compat wrapper
In-Reply-To: <20260323151733.4175605-1-yphbchou0911@gmail.com>
References: <20260323151733.4175605-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1.

Thanks.

--
tejun
