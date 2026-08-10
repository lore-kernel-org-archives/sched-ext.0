Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777F93F484D;
	Mon, 10 Aug 2026 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786391495; cv=none; b=Pe8BAW5J1O6UolFxy+bav3Kqm9gcl27LaE+4UrsJzwchcijEDC50AtMz6VgHf1QaqzkCAXvPuVSIim1bGwO6i4pQn3wSGEWiIqqyfgoRWAcsa6qp8zD5yAOdXQiHgQsiA0v2kf2RwAwwHhxFEi+kM2Sf2q2Kbr1x1O4dwScx3p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786391495; c=relaxed/simple;
	bh=286DKP7EYWnggjEkXb9NUKoDBTmGKiRd8QyJHJItIKg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=UEKSkebgyzA5DbhtH1W2+q7N8Wmye7Wb+XfblgsOL3hAizEogfSc4nwX8wcwEz+yCdkQ9mXgN+D80dwhHzmenbjbYTSzzbNzO2EQ8/5pKixe3BALIqRdo1T/P0t0JiWpsX3dwJSf5qSn5iR/GakeyswycI0T+ahBsb6mKgLuj/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moxocVMT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moxocVMT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A3B1F000E9;
	Mon, 10 Aug 2026 19:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786391494;
	bh=286DKP7EYWnggjEkXb9NUKoDBTmGKiRd8QyJHJItIKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=moxocVMTB8IeJ8ufXTzzVGrOdKW2emWtp3JjZe9DNDcgePLnReVI+gUSNFOKdbG+n
	 bLMdl2kagpUa45kKZl5qC/midY/AOIESW4ebHYUk72VKRu4Tz5s/UJq2Htyj1O7NBS
	 QTvCxTgWCV36dAzlYtfLEgHQQkb7MTUDlx6ryQ4Z0filagUQY/uMo3LEPUhMxDtXsy
	 LV4xRRnZBqUG2BligmHDuInIiyIlyvBtexiquUmEJEj8BOHvkeh2fNpbPrtrSTe4cd
	 zjVeoI/9csJCZutHrh5Crazl3LdwlW69ItOQK7m3g2xwdZOD9PIqzt59izbZMFWO3d
	 rSDstcnH+aFVg==
Date: Mon, 10 Aug 2026 09:51:33 -1000
Message-ID: <be272d1846ab6ef0a9bef0fb3218c07e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Liang Luo <luoliang@kylinos.cn>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/sched_ext: Check skeleton open failure in
 exit test
In-Reply-To: <20260807013912.3178229-1-luoliang@kylinos.cn>
References: <20260807013912.3178229-1-luoliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3.

Thanks.

--
tejun
