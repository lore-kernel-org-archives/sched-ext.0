Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB81F358391;
	Thu, 26 Mar 2026 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774556172; cv=none; b=PTeZQjdRn9/zz0q+nvpyOhOdzq7JkAHSw2U/ueDFkB9IuAF6TajEeJ7Scq+bkes6YRBfr77ZKIQNdT1HSu5desRjNQozXb/iSK8kdAg26JMrGomDXSPRaaccc91k7YbivU5/2h8qg7l38iso+9owkVeBNE/dtzPyLvsUqzXWpxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774556172; c=relaxed/simple;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=FqsQNkhi46+BYHkhdcu32XlpmwsSf12mvKEW/nPEdo2I5sB0YK9CIjHJ2UaiHxsOQfST1/6l2xqzLgEwhTNVX0Rt4cQby+//HIAthFQn2TtwZi9a9QThVoBf4uJen2m3xTxQKKAxAQoHLyt8yS2cFRecPJC/X3sgikIsKugGRYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpJ5q6wG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpJ5q6wG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A98CC116C6;
	Thu, 26 Mar 2026 20:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774556172;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mpJ5q6wGvitg/H32RD4eFTXlDZsgHlkp8xf9l101oVeDU3K15xvomjr/gjWZVQgxI
	 dmEdxn6OKgSUVLPZJBINNvYtLyFnR5+LnrC6TI2RKKAdwolWcgS6wa/vEzTY4HUjZ/
	 cU4sfexcFuaPnIeAPK4vk91SX4YX3IW49Wrj8o6jcLGh1pJcODw12RJapoTON/BjoA
	 fFQnXASvm1JLYvDUyXQyayjIdi9pWfpW4fQt2C3Ol4gbBf03i3rY6Q2QrsUis/GOJz
	 vHTMmbSYG9hBmTV8pL1JWBy/gZOBVG1oqK0EErIGavCCgcyHrbPbttaaX6+d3ITHCv
	 L5DFGJ7T3rmWg==
Date: Thu, 26 Mar 2026 10:16:11 -1000
Message-ID: <ed354d80d9f931505cd6123b0d0afb2e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhaomengmeng@kylinos.cn, emil@etsalapatis.com
Subject: Re: [PATCH sched_ext/for-7.1] tools/sched_ext: Remove redundant
 SCX_ENQ_IMMED compat definition
In-Reply-To: <20260326201354.2837750-1-tj@kernel.org>
References: <20260326100313.338388-1-zhaomzhao@126.com>
 <20260326201354.2837750-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1.

Thanks.

--
tejun
