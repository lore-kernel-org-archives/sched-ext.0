Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300CA26F288
	for <sched-ext@lists.linux.dev>; Tue, 30 Jun 2026 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782841583; cv=none; b=rZ1tpNWZRnmm5Yh0pA2y5sb2hIPfoMuSeWUA0ssKybpSygMaQzmXSL/nrY4CBFoa8xi/JZnFPpttByAEmJqEhRzPGA6Z3BYaviouhM3Y4yHPCEneX5/TuibmJM51jO0r5nISZvjGR7jPB55PulZUT7uzFw1egL//5iDv+xQDNQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782841583; c=relaxed/simple;
	bh=I2QK9lIu/kHz8VoOByhyXCbekAYCaGixZmDj4Rp7C8E=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=oqi5Sil+u0sSx36yZ8imbvkxZf4ImG7ybw9cnkNPOZClNxzTMmP/Qop3kS+q1bE39dT1LBDckxECHQ/FkWsEpctrsT2Ix6Cv9/pWw47Hq82OQACDIKZrP/ayrhhNi+uTDst1TpHXug0dIqjNo8tYNyjNPIcmsJiNpRpVtUozL/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qf9Wycz2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qf9Wycz2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCD11F000E9;
	Tue, 30 Jun 2026 17:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782841582;
	bh=I2QK9lIu/kHz8VoOByhyXCbekAYCaGixZmDj4Rp7C8E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qf9Wycz2sVgUErLd4zUTiqkKz+vPlDt6jwPE4Ba0lpSA5HSAOpwE1HREHU/6gJJTW
	 uEY6i+EHSECC4Ub9mUT6QUINJ4GulVpotIH6kzdNBZhOpgxRccoNcXfdn3h89viKSW
	 843qKFKhuQp/7tKR4zaIlRGgZlHMBkHzOmDsX0LfKxCai6/B59+xgAvr7ZwmFzcSIt
	 gclNL81FSSi51dPC0C42paMFTVaTNAdjswT5BDwjDpKkf61iutpGBp7zCW76Ys46uJ
	 txG1YTcyfiQVZ1IUQ8Zwj6/Uvtj2G+3B7fOcylsTk0zbIhyiDAMi35qswoZgnffG3n
	 YjcEKmJXLEaiQ==
Date: Tue, 30 Jun 2026 07:46:20 -1000
Message-ID: <c8d98f7f1c87e8ccc0b2b3a9a473a4e5@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>, chengyang.chou@mediatek.com
Subject: Re: [PATCH sched_ext/for-7.3] sched_ext: Parenthesize local SCX_EVENT defines to fix checkpatch error
In-Reply-To: <20260630170544.18772-1-yphbchou0911@gmail.com>
References: <20260630170544.18772-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Wed, Jul 01, 2026 at 01:05:35AM +0800, Cheng-Yang Chou wrote:
> Fix checkpatch "Macros with complex values should be enclosed in
> parentheses" error.

Applied to sched_ext/for-7.3.

Thanks.

--
tejun
