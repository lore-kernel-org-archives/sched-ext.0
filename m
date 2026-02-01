Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865682749D9;
	Sun,  1 Feb 2026 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769966018; cv=none; b=YA1k4OAKLbwkpRlyAWttY0EKGxhB9LunRE6CQMT3MQf7MVCHpvaTHafqtSsHTi5V1TkQKulQiSp+cRvhIbEbLNoV8MqiKgMS5g9r31SVr8u2vsiKMYxv67YzgoGppV+aNqm1bsLAel1GXuM6PqeVireG1D7Wgw0Spxcm8Aqc6Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769966018; c=relaxed/simple;
	bh=JWRtGvaldPT5AzaEDuiJc4RwiNP3k/NJWW3tBYg5vOc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=tcAymF2yZphfQ4OFmuu7Gd7HRMSkv9xbE6VHoHrTBljlu4PNQPtuuVl0VKdzEpJhaLjRAwgQ5YSIsTNeO6mPZkhkmxcMiclpQNXA7IedOmy0Y7zQrJFGLj7BgHWAt+pdLUW84Gldc5RUwqwk2czejVrovM73sAY4aat5Prx4y5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYy8OgaV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYy8OgaV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8639C2BC86;
	Sun,  1 Feb 2026 17:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769966018;
	bh=JWRtGvaldPT5AzaEDuiJc4RwiNP3k/NJWW3tBYg5vOc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DYy8OgaVxJbaNBCEvnTBRdimoBbE51cAwZC3ucLXjpsO3sXIZhtoEBWiyuR6Z9xNu
	 Daa2C+NZ4052MZr4fyyRmkb4LcewVPXbzh88PiUs6j2FUkib8fyI4bnKKiPi69msaT
	 9T8z1L0+biU5uHdSl4xxUt18niR1Z1ePl5akZwV9/iZ2gTcDKdiG467bqnON12DPK6
	 xtQ891LTM2guzyUsg9akk1/Jgl1HuwmQTdhAoNUDEN8pyqnWknHQ/j1xnDHVOUD+iW
	 U+9JbLQ6yDDcKeOLUMDksQ7fY9lB485aZ/Zrs3u8F9ZjMqM2zniMai71qUwt5M+acl
	 rI4S8qjHzrlZQ==
Date: Sun, 01 Feb 2026 07:13:37 -1000
Message-ID: <b88bcd332e9096b07c42d4e85d7eaf65@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: zhidao su <soolaugust@gmail.com>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 suzhidao@xiaomi.com
Subject: Re: [PATCH] tools/sched_ext: Add error logging for dsq creation
 failures in remaining schedulers
In-Reply-To: <20260130105511.250947-1-suzhidao@xiaomi.com>
References: <20260130105511.250947-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.20.

Thanks.
--
tejun
