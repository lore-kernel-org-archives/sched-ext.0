Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C491E570B
	for <sched-ext@lists.linux.dev>; Thu, 19 Jun 2025 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750325577; cv=none; b=DSK5W4JiaokZ66akDajhCsO0ZUHZ7kMNG6HNnU+aT84bgZqsrtT02SB6HTehcQ+S3KEmHUmicw4/hvWG9NLSStLxGKoZhui0+n5JmQXIJ9gS5vuyWLsgHksDkJULo5FklNzAonQ9imM6QDTBPhR2OoauMm1/8vCw3OYpqwzv/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750325577; c=relaxed/simple;
	bh=xjVKuuSlLSIaDqZra0DotW85Cx7pab7qYK1r9J0rDMs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=uiu8Gk/gMvsQM3x5bMmuWsXYT8senCCCujAt54k9BxTFYXuTj3J07xSZgVJVgb6FI5MiCUTrw+/bdKiuiDoRhh1qNG8twbRCVDKuq/FqaadkD2hMdCsAP6qnCykbiVhosN7s3zI1cRfpZOQMHh1mvBb6x+b0GcG5MOBzV16sxiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=BOSaYlD+; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="BOSaYlD+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:To:
	Content-Type; bh=vpo8WS5RxBbtYyKNaP16wJRHC1kulefN5hQP/h0rWWc=;
	b=BOSaYlD++b+lFRqG3SQ+lI5+7W70R8vMpdZyAXRypEGX2tf7vkBMry6KgOiPnB
	v3Rry0rAxmvSvcC9g4WE94aFDaJRlY0N8J0YYKn/iXIJIAMH4bmJaE/aCE3FxYpA
	2JRkY6VNPw61On2RmQRqWKJNxXx7Lan+7sxTCzF0/nh0c=
Received: from [172.24.148.160] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3nztD2VNoromaAA--.8290S2;
	Thu, 19 Jun 2025 17:32:51 +0800 (CST)
Message-ID: <314b931d-8c7b-4a73-9bf5-00749f068767@126.com>
Date: Thu, 19 Jun 2025 17:32:50 +0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: subscribe sched-ext
From: Honglei Wang <jameshongleiwang@126.com>
To: sched-ext@lists.linux.dev
References: <6730fe54-c9fe-4560-bac9-c152f14bff89@126.com>
Content-Language: en-US
In-Reply-To: <6730fe54-c9fe-4560-bac9-c152f14bff89@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3nztD2VNoromaAA--.8290S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RA73vDUUUU
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbirwJxrWhT0huZWgAAsA

Sorry for bothering.. Just forget the subscribe stuff..

On 2025/6/19 16:44, Honglei Wang wrote:
> subscribe sched-ext
> 

