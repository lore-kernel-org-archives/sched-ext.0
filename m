Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119882F069E;
	Wed,  5 Nov 2025 22:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382655; cv=none; b=HGGGDwrXVPFNW8icSFTTWglWoDbFoRWpW0zahRMFP5udGU8Wp5sS9ZMjObTD1ld1DDtf3L+nH9wEQbNP4PuG1EQzeEGNkUPP4Xv/qWF/S3yZh+dwKABu+hkd4eoOUbjZ7Rv9HwP2KmTr0gFVyIPKIBUysMIdLRzL92U6PMkCyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382655; c=relaxed/simple;
	bh=KlxQwxQiOyaOmfqlFrMqSOenDkOWYeInFu7SxGIC7qI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=CHNneX+0RVK+rcYeC5aeNZAIz2jpNwLB5ma6tweJpkeQy+/ZWpp2ooG3iU1OolWnUSBCDOExGsM1jfS29mq4jFnceBm+LToseb9WBmem8KK5gxHKQpk01yNPHla9ZgCZwEAjusiuF2/MinOJ95qKf3O+yesbB4BnzxoXdchEo6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5SEi+yL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5SEi+yL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E92AC4CEF5;
	Wed,  5 Nov 2025 22:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762382654;
	bh=KlxQwxQiOyaOmfqlFrMqSOenDkOWYeInFu7SxGIC7qI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B5SEi+yLv0Jmgi7AQ7f+69M5IJSSzDg5zEenhnwBRbAeA8VTdFmwc2MzdmO0mUFSa
	 6j/BgvXqMrJJxUF4Us8EmLI7TYFMtMliSRJOKnwAUJDfxFgr4U4Rlz0UsxtOCE2Uro
	 C0J7D+r9HnKx6NMNh+rz4KKeRYe91XYMiim8RyHcMcAW/nMwtcQ2ofvHYFtBdgaObI
	 0dFJgNrHE0zLTy1dg/CiY63QTY4l5xNrGkwkjPieOSZx3/hJe9ImTAtsqIxj54dn0q
	 5u6/MjWbJnENw4U1h3CKZ1Mj7Q3N/Ede1qgeVB8z04iEEvdCcs+URZ+cHQ7kHZWHX1
	 zv5Iy/1GxJmaQ==
Date: Wed, 05 Nov 2025 12:44:13 -1000
Message-ID: <58e0084431e8b64098a3f1fc86a6719e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.19] sched_ext: Mark racy bitfields to prevent adding fields that can't tolerate races
In-Reply-To: <5d2305143c29ed781438acc9b92fb781@kernel.org>
References: <5d2305143c29ed781438acc9b92fb781@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.19.

Thanks.
--
tejun
