Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526CD33A6F1
	for <sched-ext@lists.linux.dev>; Mon, 23 Feb 2026 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869425; cv=none; b=G/bNijk8lQGEHcHccr2CeM9ORdJrf/rtup55Df79U+Lywx2pF88bFULi+CUpENKQx3sWO8GotBvEAiiypl8nolar2R3WNOWxKv0Z97NsZNWwo6ZqmuMc1Gdu+pdFsng1K9nTDHWDWsMAooUBMwb7gpEIIjY1oXQImH2vcd5SKKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869425; c=relaxed/simple;
	bh=Dujl1pyODKwK+oxQ6izHB8ApVqOc2we5zyI20DnnL6s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1KJTXE+BE0IaMLEcvMwb/hIMWvumxbUcxn9mxFEATvXJJliDIw42MAJUe1fANW+Hg4JYXsFuKPc1UKGsk6jDI358B29LGyVvzehKKbfd4U/XK+HW5yBdSPuKdqwWkNYpRFD3g0jAtEypYQI/JG9UGixU2DZefCyvISzuBy9xlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2cvHl4N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2cvHl4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BDAC116C6;
	Mon, 23 Feb 2026 17:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771869424;
	bh=Dujl1pyODKwK+oxQ6izHB8ApVqOc2we5zyI20DnnL6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i2cvHl4N41dNwFRsF45sIiXnfeS0GlCJjve8p5akXph33AnVOKWQujc4kuB02QcZf
	 LTJK28jHotOIN/usPwxtY4Iv2tA5ieJIeNRtPiLp3TpcfeKgZl6+LBssMGBpAmCydu
	 +b75eNgQR0bVJOzHG9Nd0Z32nEwCkaFUpMkNVilkD2VwBa+5QFlqDjaCngdVAPAv5d
	 /2FVslUTNN35J7nmKKZ3pkWZ+7Vo10SfVQko9wTq1+AbY5r4hJcQAYCJCh+A/+Rdh/
	 +t2dRZV/FsDjEdgTrQDTdc3dk5F7O/bwlQp8KjsF+G4jg+MfrRLnX6TZHUveY5CBgc
	 DZbs3YVhSZ4lQ==
Date: Mon, 23 Feb 2026 07:57:03 -1000
Message-ID: <d0778323171e463c0b68c9c5d3ec2a28@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, void@manifault.com,
 arighi@nvidia.com, changwoo@igalia.com,
 jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH 0/1] selftests/sched_ext: Fix unused-result
 warning for read()
In-Reply-To: <20260221125615.1119571-1-yphbchou0911@gmail.com>
References: <20260221125615.1119571-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

> Cheng-Yang Chou (1):
>   selftests/sched_ext: Fix unused-result warning for read()

Applied to sched_ext/for-7.0-fixes.

Thanks.

--
tejun
