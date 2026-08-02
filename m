Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7333325B093;
	Sun,  2 Aug 2026 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785702026; cv=none; b=fqQz/AvGFT1uOD1ETAvpLkUffAUxuVj6RLC2nbJO0fu8bUQhVzYx5ehKf2qP6rYJs4aaz1cpJZKyNFSqYJdRwHQrxfEMVWbddHmpu/413bhX9DPlHP+LhlOL9dpnSOqQQof6heSRX0ZiqSvxl5zfpRVt6g+AD0IfbfH6KdaDfwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785702026; c=relaxed/simple;
	bh=286DKP7EYWnggjEkXb9NUKoDBTmGKiRd8QyJHJItIKg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=RIaF7d4I2H0NHciX+gXVyeIk2DORMVIDgiK4Z3c8QBzuURIgKI4JTar2SS1O1nrNqNzzPbam/VvOtWNnUsagoIKFtNKqS9MkM0DYFNVpV+9kT27XJW38q8gG7UU1D21gHhHdHNK3QAe0YUPJiZw+RKkX17uHXqFo4K7yWSY1AkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=di4vjNpV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="di4vjNpV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C221F000E9;
	Sun,  2 Aug 2026 20:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785702025;
	bh=286DKP7EYWnggjEkXb9NUKoDBTmGKiRd8QyJHJItIKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=di4vjNpVqib36hDGvB7O8cXatBpGie+8y/I8wxJxnvzhRh1yRgT2jEdH506YHju4k
	 ztGJ2F5hAzv76Z9h0Th3v/eCCB4CQm9LLhQ+VqpKJBGz6nKsVfxt+HZ+FALZk0IvIz
	 SIQJS5hKkSgraYaiA/AVEqrJzdYn7KDW5dCDMN6xhlTTaMmp8Gvx4v4kU7kxWI7DD+
	 LHkRr102rnJR1j1ulk7PCDfM097xjhGbJhlMk6WuRrnMbEmmZB700WpRexC4v9oqSY
	 2Ws80xFIlJWop245RTb/Y8QTTD/CyKNdjmpADHWrls7P/g1M0v8wHPe5tCLO2O/RVb
	 kBGgepcNOLnIA==
Date: Sun, 02 Aug 2026 10:20:24 -1000
Message-ID: <9f0dee5594ed033fb374f304082c2595@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Liang Luo <luoliang@kylinos.cn>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Set errno on ENABLING -> ENABLED transition
 failure
In-Reply-To: <20260728060955.4102964-1-luoliang@kylinos.cn>
References: <20260728060955.4102964-1-luoliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3.

Thanks.

--
tejun
