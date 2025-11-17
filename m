Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF6532720A;
	Mon, 17 Nov 2025 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763392684; cv=none; b=PrL0k/wWIeW8YYpYSQu2tVxCzzfor92QtokXJ122edjLm20cJ05umzJxznyXifycCMN2PcJTqhkNBcoDIFoX5agxrJc57RNXYvWPGDk7VKg1nK2rIgufSkfrrCoH6HcO+LLstv/K4u9du5fu1at9uVhru7PyitFJY1DJ20LpC4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763392684; c=relaxed/simple;
	bh=KlxQwxQiOyaOmfqlFrMqSOenDkOWYeInFu7SxGIC7qI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=AuWwqB/EnDThi9rMkrnLcsUFvibCxzvafJhFq+3mLjDhSDSrPd+rYpQVwQw5W4RF6LY/v4yLI40caJKpGMBEWkJsAWw8YdkCwbhGZ7nFEPYKRI2+CQuBiBPRkTpw5eJ9bIWdZJMSFRWjC1k91rjl+brQp+2AJxHpkjTVGdmXV7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHDffSXs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHDffSXs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BB4C113D0;
	Mon, 17 Nov 2025 15:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763392684;
	bh=KlxQwxQiOyaOmfqlFrMqSOenDkOWYeInFu7SxGIC7qI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eHDffSXsCr0bvkzdENa419MdfLoi6nluJH207E1CCTP34IDoT0LT/KzoinDH2k7VR
	 AjQGR5BX0nrLHZU99n3MSh3qc7wG5jr8l6PYrU3/3Se9Y/Hs5YatZ9dNX7s2GQ7V7H
	 9Ep0OuMLOi1PKeFGV8OgcXJsEsDPE8avSAQl7bckeSDKBFZ7dYdzd/NwBj+iDAaglW
	 xgDbmyf8qsqWF19JgRPiG242KFB7Unm2IBw1c7/JC7tIe9SWNyyQJaTVXsJXwBMIlO
	 VKLAHwfSX+HvtflgO66szfjSVJeG+SyFVNWibb06cf7167YzEMrTO114bIDk/RCPMc
	 ykaR7Yp4mCZzw==
Date: Mon, 17 Nov 2025 05:18:02 -1000
Message-ID: <c679e72987c5414ceb1ca37cbdbcebd6@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 qiang.zhang1211@gmail.com
Subject: Re: [PATCH] sched_ext: Use kvfree_rcu() to release per-cpu ksyncs
 object
In-Reply-To: <20251117125311.107687-2-qiang.zhang@linux.dev>
References: <20251117125311.107687-1-qiang.zhang@linux.dev>
 <20251117125311.107687-2-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.19.

Thanks.
--
tejun
