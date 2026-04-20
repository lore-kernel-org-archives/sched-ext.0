Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D673A875A;
	Mon, 20 Apr 2026 18:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776708121; cv=none; b=uP7hAXE4p+IFRkqwaOqceyy5qQNmW8DkgyMl3r9tudsTvr1R4nHGIC4YM5XQ6gP20SeF/2hw1/rdwuiwe75hhgovzM8xj9NiRk/5YvYYfAFGRmJc3L8/dpxdHfwRo+iEwZer6mLZy1nBsEPAxYZmboyg0gP41wn+DzI01wlHik8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776708121; c=relaxed/simple;
	bh=AL3RD12e+wd3hpXo+XZ4a0Ofa1msrCKNJWe1W8ilL1Y=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ODARLfKAOEFjY/sELo83JxStave8efXXMoBWyLtfJ7K3pNhFuzpEOgqR8NAAlRmP/fDAi3xYhL/zdMiYf6FWpXy3oBAptaag2hYO3dvAxJGoGC3TNxoxtbRISIqFKtidUyVXH8qE46khjRufO0PWeNu3keV2Ktv+0o6dNqfYIGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQCv7Rq7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQCv7Rq7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8209FC19425;
	Mon, 20 Apr 2026 18:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776708120;
	bh=AL3RD12e+wd3hpXo+XZ4a0Ofa1msrCKNJWe1W8ilL1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XQCv7Rq7mvXpz0NsbGddnePPdssrjT5WbCRJZafgjdERv0Bux4a9UxmgUUIRkhrsL
	 Thtye/KNnm5XdxEmTTDij9rm4DXBxbVilooKA1uzyR1hNNFzPWTu6SIaLpTHYEwwvA
	 DLW09ydtFNSLrch38ik5+/PXCyLCQMVZBQuCLfxaf58iDb6eWoTjung4cDw5Rp0p2i
	 i8+JAZZNSDNvtZGAOJoZo8IV1tWdfhapYLg7NV9S1VsN4XOvQSVgGBde8WXALnX8nz
	 0E3HqjLmjPQttccjo+lJy+h+f9uO059NgEFDqys0wP8LoT2MVSzhG99dIDJLopwLQ9
	 Ca4ZpFtu1ih2w==
Date: Mon, 20 Apr 2026 08:01:59 -1000
Message-ID: <7e4aa7dbafae4599fbba05d1b7454c9a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 David Vernet <void@manifault.com>,
 linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev,
 Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: Re: [PATCH v2] sched_ext: Documentation: add note about multiple
 ops.enqueue() calls in a row
In-Reply-To: <20260420152847.3690794-1-jpiecuch@google.com>
References: <20260420152847.3690794-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.2.

Thanks.
--
tejun
