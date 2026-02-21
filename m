Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1E63126C0;
	Sat, 21 Feb 2026 03:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771643989; cv=none; b=V5ESZ+NZEeDuJz8o9Xi75IljEPyB0W+mhzLaWYwB5rQ80pBikT4CumCkR8pAtmSW73wWrwxS6D5LDz/Y8bUiFv9/nBnLQX4/+oG4KrtoQjr4JgqNcZglNJaLReXoO2WgEekKReWp6iIBi3xF7mocdDEYBltSK7UJRqgzLMXce5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771643989; c=relaxed/simple;
	bh=5/Jg/cpVR7WaUS8y+4lvIsX6pu4+Qt9Jv+1IUK5YwJ4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=CaGAVys4OVE7Pbj0NFijFrKkQutZ4zNYvWsW2Tv9/5B14E+FlrSXf7cljsgw4sK1pZgaJHxSm61vCRCqOQ5gorqj2kkMNB5X6YYLHefnLZqVfILMLJPSVCEmrbqzKstVFFbwZukHSucJG1xdk8q/fIObdDgEC9ZjQ/DYppggXg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cblJeq70; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cblJeq70"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C606C19422;
	Sat, 21 Feb 2026 03:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771643988;
	bh=5/Jg/cpVR7WaUS8y+4lvIsX6pu4+Qt9Jv+1IUK5YwJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cblJeq709mjUvLe/VCg8wozwvrb0XLHHUDQrFDN4OOTuc2375a122vf+z2AKPNV9p
	 06R45Hu3iOOaRIXjdAwDXue54QhPsWaaaDBkMaUgIuL0HrUOVsdeXP6/BQWMLXAbt1
	 PvyGxwQbARTZ2b2WPH6er474Smghd/kC4uysO6xDS7xGqitJon0IQVs/VO7Non1xXq
	 eooLcTn+Etd3tZSHxz6wxQgDWMVV2yPV0EQLAhtkRZRiJ/UhYMT7l9kzaglAarkASu
	 xCGZ4ZHkm083ybRbYa6UcXrSTILHC9e+oqaPt+xgNEi6kt4dCwBs/htFsOFY3rk7xl
	 Qqtr2FsQEbzvQ==
Date: Fri, 20 Feb 2026 17:19:47 -1000
Message-ID: <d522456b585409d5586ce897cce8b1a4@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: David Vernet <void@manifault.com>,
 linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] tools/sched_ext: fix getopt not re-parsed on
 restart
In-Reply-To: <20260218192235.8699-1-devnexen@gmail.com>
References: <20260218192235.8699-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.0-fixes.

Thanks.
--
tejun
