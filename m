Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E57331E84A;
	Sat, 21 Mar 2026 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774118535; cv=none; b=M0vnyWlhNOUYdDrBvhPDTdwn0szBbIu8a5YDvfAolLlgOQzwxUpSzVt62gakj3Cvr1bVfb6MTQ/vDCg0MCwxlmXq4s8bQIY7QAeOqhd36saZ+87Dm2pHcLcWohtQGUc4wlvUaDtA46HekdHAZm3UI4RFT9wKBMe/B0F1VdFrnCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774118535; c=relaxed/simple;
	bh=mflRttZd2cJen+lGPYTx5LWAfqVuKCSaHiDW9sR6mO0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=SbQbea2USwgTwgKK4v9L9ndm3LZM22rSU9gMUehjTDD/m9oR+IIFtpHnff9dE980u72zzfVMLWTiBcK57tw1xsuWA0kc62lSHZSpB65oSp+3DIwOanzHGmo9jNOKZTxUISTH+4k8WSIPSKh4UmMCDyl5MakMAVHCbJ7XWE7w4QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeDcIDcW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeDcIDcW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18DAC19421;
	Sat, 21 Mar 2026 18:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774118534;
	bh=mflRttZd2cJen+lGPYTx5LWAfqVuKCSaHiDW9sR6mO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AeDcIDcWvnb5Z4JuAFCzNsY2Zm+D5s244LuNEyx3So+8k06H2/ggjnG/w0+ynJ4H6
	 ErWpWao2ze9LMEDfRsPBVAehV122QdKh5c0OMKOCLG+LD3/uykiuNCSQdU+P0W0jFb
	 AmJHFrP8j5reaY8kSjbPPtvojqFsHep/U6o4hFN+OL/CtsVUuuKvCjL1PcHQz5Lsk2
	 Suvi3114kdzmzpb+AW8n5SziaThBZ/iE/7I2cuby2YAJqPGUK3QqAJKUZKqA0PyWrm
	 u9t+ZfVDMuyZrPQOKkuRhwo2cIf3xwkqr1eTB9pEDq/37exTGyu14dLrNbSRt8NjRV
	 FMnMgGizd3L4g==
Date: Sat, 21 Mar 2026 08:42:13 -1000
Message-ID: <c30307f7e69ca3abd6223cf7a9f64351@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix inconsistent NUMA node lookup in
 scx_select_cpu_dfl()
In-Reply-To: <20260321105503.869337-1-yphbchou0911@gmail.com>
References: <20260321105503.869337-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.0-fixes with the following additions:

  Cc: stable@vger.kernel.org # v6.15+
  Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks.

--
tejun
