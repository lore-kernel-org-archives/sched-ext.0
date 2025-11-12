Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F043734DB7F;
	Wed, 12 Nov 2025 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974015; cv=none; b=R5rTufsKqLwoMfmp2+BJYkUPbBekIEQMah38WCRq/4TEk+sCBjVe0rsyhKLMgxxal90nTNlnCh99Cx7wrcxTMuJ1/0QO+tRRXM/8pKbgH5tdZMKYb+CLjOoFiWyNutOrOz97a3TtmTwGdhqmxqpdJYlM6JWWk//7dt6fRBcZFiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974015; c=relaxed/simple;
	bh=KlxQwxQiOyaOmfqlFrMqSOenDkOWYeInFu7SxGIC7qI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=dqOrvBC2qpnxhLUyvu4pZpgIRMdDSTC9FpDYrLqSY+h+ZCZcsVxl795VvzfkPyWZHRQ1jaQ4Mf6mAKZDpUg4EZhHSsx8yTVDyV3vABHVN/+zuRkNkJOagBo/OjusdSB8qePubyzzhj+/DU7lH1GfSZEQBAeCgXmuv5fc9V62GgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kctgopUZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kctgopUZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DB3C2BC9E;
	Wed, 12 Nov 2025 19:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762974014;
	bh=KlxQwxQiOyaOmfqlFrMqSOenDkOWYeInFu7SxGIC7qI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kctgopUZA0oX5BT9cJV1hk27TO16LI3GC7SZBzy5TyBYNnV+IJyOTRS02IbT7YeH9
	 1qx+NEL/KoydhpClRIpvUedu4IXueLeztvOphBrtSynWwZ54TzVQ8zTXcycYEVAl24
	 I/T1lyp12JkR8M7vxqe8qnCbnwpiv9ODqXTIMZIYMksWjRCUa5amMfUrQLbO2++ueW
	 mJGytVgvj5xsuwy0ZQNVEAneq6STaTDXPLDP9hKPvQB7XWOIc3XhEeZQOIr/wogSAs
	 Aw2eibpBbwzrNMPN0+Ac+DRwc3ju0Lj8u0Gua6+O0qtHfRQ2to/XQ7Ycoj0FXyk1Q+
	 PdDIhKE7+WxGQ==
Date: Wed, 12 Nov 2025 09:00:13 -1000
Message-ID: <053bd6357b7f242c3bb51af674c816ab@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.19] sched_ext: Update comments replacing breather with aborting mechanism
In-Reply-To: <20251112172945.299874-1-arighi@nvidia.com>
References: <20251112172945.299874-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.19.

Thanks.
--
tejun
